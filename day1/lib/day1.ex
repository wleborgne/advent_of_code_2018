defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day1.hello()
      :world

  """
  def hello do
    :world
  end

  def puzzle01 do
    File.stream!("drift_values.txt")
    |> Enum.reduce(0, fn val, acc ->
      val
      |> string_to_int()
      |> Kernel.+(acc)
    end)
    |> IO.inspect()
  end

  def puzzle02 do
    :ets.new(:frequency_store, [:set, :protected, :named_table])
    :ets.insert(:frequency_store, {0, 0})

    File.stream!("drift_values.txt")
    |> Stream.map(&string_to_int(&1))
    |> Stream.cycle()
    |> Enum.reduce_while(0, fn val, acc ->
      curr = val + acc

      case :ets.lookup(:frequency_store, curr) do
        [curr] ->
          {:halt, curr}

        _ ->
          :ets.insert(:frequency_store, {curr, curr})
          {:cont, curr}
      end
    end)
    |> elem(0)
  end

  defp string_to_int(val) do
    val
    |> Integer.parse()
    |> elem(0)
  end
end
