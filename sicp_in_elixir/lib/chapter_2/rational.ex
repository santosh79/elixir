defmodule Rational do
  def add_rat(x, y) do
    num = numer(x) * denom(y) + numer(y) * denom(x)
    den = denom(x) * denom(y)
    make_rat num, den
  end

  def mult_rat(x, y) do
    make_rat numer(x) * numer(y), denom(x) * denom(y)
  end

  def make_rat(num, den) do
    fn(option) ->
      case option do
        :numer -> num
        :denom -> den
      end
    end
  end

  def denom(x), do: x.(:denom)
  def numer(x), do: x.(:numer)
end

