defmodule FixedPoint do
  @doc ~S"""
  A fixed point is a function that takes as argument a function `f`
  that has this property of converging on a value when being recursively
  called.
  ## Example:
      cos(cos(cos(0))) 
  Appears to start converging towards `0.743`. It also takes as argument
  a `start` value
  """
  def calc(f, start) do
    calc f, start, f.(start)
  end
  defp calc(f, old, new) do
    cond do
      good_enough?(old, new) ->
        new
      true ->
        calc(f, new, f.(new))
    end
  end

  defp good_enough?(a, b) do
    abs(a - b) <= tolerance
  end
  defp tolerance, do: 0.000001

end

defmodule Sqrt do
  def sqrt_new(num) when num > 1 do
    import SicpInElixir, only: [avg: 2]
    avg_damped = AverageDamp.calc(&(num / &1))
    FixedPoint.calc avg_damped, 1
  end

  def sqrt(num) when num > 1 do
    import FixedPoint
    import SicpInElixir, only: [avg: 2]
    calc &(avg(num / &1, &1)), 1
  end
end

defmodule AverageDamp do
  def calc(f) do
    import SicpInElixir, only: [avg: 2]
    fn(x) -> avg(f.(x), x) end
  end
end

