defmodule ConsCarAndCdrTest do
  use ExUnit.Case
  import ConsCarAndCdr

  test "simple test" do
    a = cons 10, 20
    assert car(a) == 10
    assert cdr(a) == 20
  end

  test "list" do
    one_thru_four = 1..4 |> Enum.to_list |> list
    assert car(cdr(one_thru_four)) == 2
  end

  test "list_ref" do
    one_thru_four = 1..4 |> Enum.to_list |> list
    assert list_ref(one_thru_four, 2)  == 3
    assert list_ref(one_thru_four, 20) == nil
  end

  test "length" do
    one_thru_four = 1..4 |> Enum.to_list |> list
    assert ConsCarAndCdr.length(one_thru_four) == 4
  end

  test "append" do
    one_thru_four  = 1..4 |> Enum.to_list |> list
    five_thru_nine = 5..9 |> Enum.to_list |> list
    one_thru_nine  = append one_thru_four, five_thru_nine
    assert to_ex_list(one_thru_nine) == (1..9 |> Enum.to_list)
  end

end
