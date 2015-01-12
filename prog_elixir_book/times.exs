defmodule Times do
  def double(n) when is_integer(n), do: n * 2
  def quadruple(n) when is_integer(n), do: double(n) * 2
end

