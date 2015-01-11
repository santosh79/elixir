defmodule AreaServer do
  def start, do: spawn(fn() -> loop end)
  defp loop do
    receive do
      {:rectangle, wd, ht} ->
        IO.puts "Area of rectangle is #{wd * ht}"
        loop
      {:square, side} ->
        IO.puts "Area of square is #{side * side}"
        loop
    end
  end
end

