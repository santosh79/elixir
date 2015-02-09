defmodule Intervals do
  def make_interval(a, b) when a < b, do: a..b
  def lower_bound(interval), do: interval.first
  def upper_bound(interval), do: interval.last

  def add_interval(a, b) do
    lower_bound_sum = lower_bound(a) + lower_bound(b)
    upper_bound_sum = upper_bound(a) + upper_bound(b)
    make_interval lower_bound_sum, upper_bound_sum
  end

  def sub_interval(a, b) do
    lower_bound_diff = lower_bound(a) - upper_bound(b)
    upper_bound_diff = upper_bound(a) - lower_bound(b)
    make_interval lower_bound_diff, upper_bound_diff
  end
end

