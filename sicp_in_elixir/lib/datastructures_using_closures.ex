defmodule DS do
  def stack(list \\ []) do
    fn(option, el) ->
      case option do
        :push ->
          stack [el|list]
        :pop ->
          [h|t] = list
          [stack(t), h]
      end
    end
  end

  def push(stack, item), do: stack.(:push, item)
  def pop(stack), do: stack.(:pop, :void)
end

defmodule DS.Test do
  def run do
    import DS
    s                   = stack
    with_ten_and_twenty = s |> push(10) |> push(20)
    twenty              = with_ten_and_twenty |> pop |> Enum.at(1)
    ten                 = with_ten_and_twenty |> pop |> Enum.at(0) |> pop |> Enum.at(1)

    20 = twenty
    10 = ten
    :ok
  end
end
