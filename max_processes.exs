defmodule Processes do
  def max(num_processes) do
    :erlang.statistics :runtime
    :erlang.statistics :wall_clock
    
    pids = Enum.to_list(1..num_processes)
      |> Enum.map(fn(_x) -> spawn(fn() -> wait() end) end)

    {_, time1} = :erlang.statistics :runtime
    {_, time2} = :erlang.statistics :wall_clock

    pids |> Enum.each(fn(pid) -> send(pid, :die) end)

    time1 = time1 / 1000
    time2 = time2 / 1000
    IO.puts "Process spawn time is #{time1} and in micro-seconds is #{time2}"
  end

  defp wait do
    receive do
      :die -> :void
    end
  end
end

Processes.max 400_000
