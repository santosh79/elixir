defmodule STimer do
  def start(func, time) do
    spawn(fn() ->
      receive do
        :cancel -> :void
        after time -> func.()
      end
    end)
  end

  def cancel(pid) do
    send pid, :cancel
  end
end

