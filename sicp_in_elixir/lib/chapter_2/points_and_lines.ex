defmodule Point do
  def make_point(x, y) do
    [x_point: x, y_point: y]
  end

  def x_point(p), do: p[:x_point]
  def y_point(p), do: p[:y_point]
  def print_point(p) do
    IO.puts "\n(#{x_point p},#{y_point p})"
  end
end

defmodule Rectangle do
  def make_rect(origin, width, height) do
    fn(option) ->
      case option do
        :width  -> width
        :height -> height
      end
    end
  end

  def perimeter(rect) do
    (get_width(rect) + get_height(rect)) * 2
  end

  def area(rect) do
    get_width(rect) * get_height(rect)
  end
  def get_width(rect),  do: rect.(:width)
  def get_height(rect), do: rect.(:height)
end

defmodule LineSegment do
  def make_segment(start_segment, end_segment) do
    [start_segment: start_segment, end_segment: end_segment]
  end

  def start_segment(line_segment) do
    line_segment[:start_segment]
  end

  def end_segment(line_segment) do
    line_segment[:end_segment]
  end

  def midpoint_segment(line_segment) do
    import SicpInElixir, only: [avg: 2]
    import Point

    start_point = start_segment line_segment
    end_point = end_segment line_segment

    mid_x = avg x_point(start_point), x_point(end_point)
    mid_y = avg y_point(start_point), y_point(end_point)

    make_point mid_x, mid_y
  end
end

