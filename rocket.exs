defmodule Rocket do
  def start_launch_sequence(from \\ 10) when from >= 0 and from < 20 do
    IO.puts "Liftoff in #{from} seconds"
    countdown from
  end

  defp countdown(0), do: blastoff

  defp countdown(seconds) do
    IO.puts seconds
    receive do
    after 1000 ->
      countdown (seconds - 1)
    end
  end

  defp blastoff, do: IO.puts "blastoff!"
end

Rocket.start_launch_sequence

