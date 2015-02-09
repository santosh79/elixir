defmodule IntervalsTest do
  use ExUnit.Case
  import Intervals

  test "add intervals" do
    a   = make_interval 1, 3
    b   = make_interval 1.5, 3.2
    sum = add_interval a, b

    assert lower_bound(sum) == 2.5
    assert upper_bound(sum) == 6.2
  end

  test "sub intervals" do
    a   = make_interval 1, 2
    b   = make_interval 2.5, 3.2
    diff = sub_interval b, a

    assert lower_bound(diff) == 0.5
    assert upper_bound(diff) == 2.2
  end

  test "sub intervals with negative numbers" do
    a   = make_interval 1, 3
    b   = make_interval 2.5, 3.2
    diff = sub_interval b, a

    assert lower_bound(diff) == -0.5
    assert upper_bound(diff) == 2.2
  end

end
