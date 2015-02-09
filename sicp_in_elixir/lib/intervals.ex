defmodule Intervals do
  def make_center_percent(center, percentage) do
    offset = center * (percentage / 100)
    make_interval (center - offset), (center + offset)
  end

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

  def mult_interval(a, b) do
    lower_bound_product = lower_bound(a) * lower_bound(b)
    upper_bound_product = upper_bound(a) * upper_bound(b)
    make_interval lower_bound_product, upper_bound_product
  end

  def width(interval) do
    (upper_bound(interval) - lower_bound(interval)) / 2
  end
end

