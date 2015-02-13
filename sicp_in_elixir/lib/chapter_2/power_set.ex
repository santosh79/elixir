defmodule PowerSet do
  def create([h]) do
    [[h], []]
  end
  def create([h|t]) do
    all_subsets = t |> create
    with_h = all_subsets |> Enum.map(fn(s) ->
      [h] ++ s
    end)
    all_subsets ++ with_h
  end
end


