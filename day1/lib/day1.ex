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
      |> Integer.parse()
      |> elem(0)
      |> Kernel.+(acc)
    end)
    |> IO.inspect()
  end
end
