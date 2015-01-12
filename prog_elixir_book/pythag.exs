defmodule Pythag do
  def calc(num) when is_integer(num) and num > 0 do
    lc x inlist 1..n, y inlist 1..n, z inlist 1..n, (x*x) + (y * y) === (z * z), do: {x, y, z}
  end
end

