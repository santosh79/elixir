defmodule RationalTest do
  use ExUnit.Case
  import Rational
  test "adding" do
    a = make_rat 10, 100
    b = make_rat 20, 100
    result = add_rat a, b
    result_numer = numer result
    result_denom = denom result

    assert result_denom == (100 * 100)
    assert result_numer == (10 * 100 + 20 * 100)
  end

  test "multiply" do
    a = make_rat 10, 100
    b = make_rat 20, 100
    result = mult_rat a, b
    result_numer = numer result
    result_denom = denom result

    assert result_numer == (10 * 20)
    assert result_denom == (100 * 100)
  end
end
