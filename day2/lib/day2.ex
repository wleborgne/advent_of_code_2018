defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2.hello()
      :world

  """
  def hello do
    :world
  end

  def puzzle1 do
    :ets.new(:counters, [:set, :protected, :named_table])
    :ets.insert(:counters, [{:dups, 0}, {:trips, 0}])

    File.stream!("id_list.txt")
    |> Stream.each(fn line ->
      line
      |> String.trim()
      |> String.graphemes()
      |> check_duplicates()
      |> check_triplicates()
    end)
    |> Stream.run()

    calculate_checksum()
  end

  defp check_duplicates(list) do
    case contains_repeats?(list, 2) do
      true -> increment_ets(:dups)
      _ -> nil
    end

    list
  end

  defp check_triplicates(list) do
    case contains_repeats?(list, 3) do
      true -> increment_ets(:trips)
      _ -> nil
    end

    list
  end

  defp contains_repeats?(list, count) do
    list
    |> Enum.uniq()
    |> Enum.map(fn val ->
      Enum.count(list, fn x -> x == val end)
    end)
    |> Enum.any?(fn x -> x == count end)
  end

  defp increment_ets(key) do
    old_count =
      :ets.lookup(:counters, key)
      |> Keyword.fetch!(key)

    :ets.insert(:counters, {key, old_count + 1})
  end

  defp calculate_checksum do
    dups =
      :ets.lookup(:counters, :dups)
      |> Keyword.fetch!(:dups)

    trips =
      :ets.lookup(:counters, :trips)
      |> Keyword.fetch!(:trips)

    dups * trips
  end
end
