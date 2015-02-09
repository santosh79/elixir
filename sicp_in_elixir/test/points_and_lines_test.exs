defmodule PointsAndLinesTest do
  use ExUnit.Case
  import Point
  import Rectangle

  test "perimeter & area of rect" do
    origin = make_point 5, 5
    rect   = make_rect origin, 10, 20
    assert perimeter(rect) == 60
    assert area(rect)      == 200
  end
end
