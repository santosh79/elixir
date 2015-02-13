defmodule BinaryMobileTest do
  use ExUnit.Case
  import BinaryMobile

  test "total_weight - complex" do
    left_leaf = make_branch 1, 40
    left_branch  = make_branch 2, left_leaf
    right_branch = make_branch 1, 20
    mobile = make_mobile left_branch, right_branch

    assert total_weight(mobile) == 60
  end

  test "total_weight - simple" do
    left_branch  = make_branch 1, 10
    right_branch = make_branch 1, 20
    mobile = make_mobile left_branch, right_branch
    assert total_weight(mobile) == 30
  end

  test "is_balanced?" do
    left_branch  = make_branch 1, 20
    right_branch = make_branch 1, 20
    mobile = make_mobile left_branch, right_branch
    assert (mobile |> is_balanced?) == true
  end

  test "is_balanced? - different lengths, same weight" do
    left_branch  = make_branch 1, 20
    right_branch = make_branch 3, 20
    mobile = make_mobile left_branch, right_branch
    assert (mobile |> is_balanced?) == false
  end

  # test "is_balanced? - more complex" do
  #   left_leaf = make_branch 1, 40
  #   left_branch  = make_branch 2, left_leaf
  #   right_branch = make_branch 1, 20
  #   mobile = make_mobile left_branch, right_branch
  #
  #   assert (mobile |> is_balanced?) == true
  # end
end
