defmodule Clock do
  def start(func, time) do
    Process.register spawn(fn() -> loop(func, time) end), :clock
  end

  def stop do
    pid = Process.whereis :clock
    send pid, :stop
  end

  defp loop(func, time) do
    receive do
      :stop -> :void
    after time ->
      func.()
      loop func, time
    end
  end
end

