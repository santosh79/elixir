defmodule Stack do
  def create(items \\ []) do
    fn(option, el) ->
      case option do
        :push ->
          create [el|items]
        :pop ->
          [h|t] = items
          [create(t), h]
      end
    end
  end

  def push(stack, item), do: stack.(:push, item)
  def pop(stack),        do: stack.(:pop, :void)
end

defmodule DS.Test do
  def run do
    import Stack
    s                   = create
    with_ten_and_twenty = s |> push(10) |> push(20)
    twenty              = with_ten_and_twenty |> pop |> Enum.at(1)
    ten                 = with_ten_and_twenty |> pop |> Enum.at(0) |> pop |> Enum.at(1)

    20 = twenty
    10 = ten
    :ok
  end
end
