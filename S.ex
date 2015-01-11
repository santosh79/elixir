defmodule S do
  def greet do
    receive do
      {sender, :hi} ->
        send(sender, "hello there")
        greet
      {_, :reload} -> S.greet
    end
  end
end

