defmodule TowersOfHanoi do
  def move(number_of_tires) do
    IO.puts "processing #{number_of_tires}"
    tires = 1..number_of_tires |> Enum.to_list
    move tires, :from, :to, :spare
  end

  defp move([el], from, to, _spare), do: move(el, from, to)
  defp move(tires, from, to, spare) do
    initial = tires |> Enum.slice(0..-2)

    move initial, from, spare, to

    [last|_] = :lists.reverse tires 

    move last, from, to

    move initial, spare, from, to

    move initial, from, to, spare
  end

  defp move(el, from, to) do
    IO.puts "moved #{inspect el} from #{inspect from} to #{inspect to}"
  end

  def test do
    move [1,2,3], :from, :to, :spare
  end
end

