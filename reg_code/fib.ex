defmodule Fib do
  def calc(num) when num in 0..1, do: 1
  def calc(num) when num > 1 do
    calc 2, num, [1,1]
  end

  defp calc(start, stop, list) when start <= stop do
    new_fib = Enum.at(list, 0) + Enum.at(list, 1)
    calc start + 1, stop, [new_fib, hd(list)]
  end

  defp calc(_, _, list), do: hd list
end

defmodule Play do
  import String, only: [split: 2]
  import Enum,   only: [filter: 2]

  def works? do
    false
  end

  def count_chars_in_string(string) do
    string
    |> String.split("")
    |> gen_count_map %{}
  end

  defp gen_count_map([], m), do: m
  defp gen_count_map([char|tail], m) do
    cur_count = Dict.get m, char, 0
    gen_count_map tail, Dict.put(m, char, (cur_count + 1))
  end
end

