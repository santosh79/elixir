defmodule RationalTest do
  use ExUnit.Case
  import Rational
  test "adding" do
    a = make_rat 10, 100
    b = make_rat 20, 100
    result = add_rat a, b
    result_numer = numer result
    result_denom = denom result

    assert result_numer == 3
    assert result_denom == 10
  end

  test "multiply" do
    a = make_rat 10, 100
    b = make_rat 20, 100
    result = mult_rat a, b
    result_numer = numer result
    result_denom = denom result

    assert result_numer == 1
    assert result_denom == 50
  end
end
