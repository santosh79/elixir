defmodule HalfInterval do
  @doc ~S"""
  This functions accepts as argument a `continuous function f` along
  with a `neg_point`, which corresponds with a point where the function `f`
  is negative and a positive point `pos_point` where the function `f`
  has a positive value.
  It then goes to finding a point in between `neg_point` and `pos_point`
  where the `f` has a value of 0. If it doesn't find one, it returns a
  point that was closest to zero.

  ### Examples:
      sample_equation = fn(x) ->
        :math.pow(x,3) - (2 * x) - 3
      end
      search sample_equation, 1.0, 2.0
      This finds a point between 1.0 and 2.0 where the function 
      `sample_equation` has a value of 0.
  """
  def search(f, neg_point, pos_point) do
    import SicpInElixir, only: [avg: 2]
    points_are_close_enough? = abs(neg_point - pos_point) < tolerance

    cond do
      points_are_close_enough? ->
        neg_point
      true ->
        mid_point          = avg neg_point, pos_point
        guess_at_mid_point = f.(mid_point)
        is_zero?           = guess_at_mid_point == 0
        greater_than_zero? = guess_at_mid_point > 0
        cond do
          is_zero? ->
            mid_point
          greater_than_zero? ->
            search f, neg_point, mid_point
          true ->
            search f, mid_point, pos_point
        end
    end
  end

  @doc ~S"""
  This is a wrapper around the above `search` method.
  It checks to see if the points `point_a` and `point_b`
  resolve to having opposite signs.
  It also arranges `point_a` and `point_b` in order, depending
  on which one is larger and which smaller and passes them in the
  correct order to the `search` function.
  """
  def calc(f, point_a, point_b) do
    val_a = f.(point_a)
    val_b = f.(point_b)
    if ((val_a * val_b) >= 0) do
      raise "Values are of the same sign"
    end

    lesser_point = cond do
      val_a > val_b -> point_b
      true -> point_a
    end
    greater_point = ([point_a, point_b] -- [lesser_point]) |> List.first
    search f, lesser_point, greater_point
  end

  defp tolerance, do: 0.001
end

