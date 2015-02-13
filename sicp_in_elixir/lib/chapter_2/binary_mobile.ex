defmodule BinaryMobile do
  import ConsCarAndCdr
  def make_mobile(left, right) do
    cons left, right
  end

  def make_branch(length, structure) do
    cons length, structure
  end

  def left_branch(mobile) do
    car mobile
  end
  def right_branch(mobile) do
    cdr mobile
  end

  def branch_length(branch) do
    car branch
  end

  def branch_structure(branch) do
    cdr branch
  end

  defp is_leaf_branch?(branch) do
    !!(branch |> branch_structure |> is_number)
  end

  def is_not_leaf_branch?(branch) do
    !(branch |> is_leaf_branch?)
  end

  def total_length_of_branch(branch) do
    length = branch_length branch
    cond do
      is_leaf_branch?(branch) -> length
      true ->
        length + (branch |> branch_structure |> total_weight_of_branch)
    end
  end

  def total_weight_of_branch(branch) do
    structure = branch_structure branch
    cond do
      is_leaf_branch?(branch) -> structure
      true ->
        structure |> total_weight_of_branch
    end
  end

  def total_weight(mobile) do
    l_weight = mobile |> left_branch |> total_weight_of_branch
    r_weigth = mobile |> right_branch |> total_weight_of_branch
    l_weight + r_weigth
  end

  def is_balanced?(mobile) do
    l_weight = mobile |> left_branch |> total_weight_of_branch
    r_weigth = mobile |> right_branch |> total_weight_of_branch

    l_length = mobile |> left_branch |> total_length_of_branch
    r_length = mobile |> right_branch |> total_length_of_branch

    l_torque = l_weight * l_length
    r_torque = r_weigth * r_length

    l_torque == r_torque
  end
end

