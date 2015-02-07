defmodule RationalNumber do
  def make_rat(n, d) do
    fn (pick) ->
      case pick do
        1 -> n
        2 -> d
      end
    end
  end

  def get_numerator(num) do
    num.(1)
  end

  def get_denominator(num) do
    num.(2)
  end

  def mult_rat(a, b) do
    numerator   = multiply_part a, b, &get_numerator/1
    denominator = multiply_part a, b, &get_denominator/1
    make_rat numerator, denominator
  end

  def add_rat(a, b) do
    num   = (get_numerator(a) * get_denominator(b)) +
      (get_denominator(a) * get_numerator(b))
    denom = (get_denominator(a) * get_denominator(b))

    make_rat num, denom
  end

  defp multiply_part(num_a, num_b, f) do
    [num_a, num_b] |>
    Enum.map(&(f.(&1))) |>
    Enum.reduce(1, fn(x, acc) -> x * acc end)
  end

  def test do
    half      = make_rat 1, 2
    quarter   = make_rat 1, 4

    one_eight = mult_rat half, quarter

    8 = get_denominator(one_eight)
    1 = get_numerator(one_eight)

    three_quarter = add_rat half, quarter
    6 = get_numerator(three_quarter)
    8 = get_denominator(three_quarter)
  end
end

