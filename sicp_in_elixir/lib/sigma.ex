defmodule Sigma do
  @doc ~S"""
  Calculate the sigma. Expects, the lower bound `start`, the increment `next`,
  the upper bound `stop` and the function to be applied to each value in the range
  `term`.
  Expects the arguments:
    term, start, next, stop
  Here `term` is the function that is to be applied to
  each invocation of this function.

  ### Examples:
      sum_of_squares_from_one_to_ten = sigma(&( &1 * &1), 1, &(&1 + 1), 10)
  """
  def sigma(term, start, next, stop) when start < stop do
    term.(start)  + sigma(term, next.(start), next, stop)
  end
  def sigma(term, _start, _next, stop), do: term.(stop)

  def sum_ints(start, stop) do
    sigma &(&1), start, &(&1 + 1), stop
  end

  def pi_sum(start, stop) do
    term = &(1 / (&1 * (&1 + 2)))
    next = &(&1 + 4)
    sigma term, start, next, stop
  end
end

