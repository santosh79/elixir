defmodule LibMisc do
  def flush_buffer do
    receive do
      _any -> flush_buffer
    after 0 -> true
    end
  end

  def time(func) do
    :erlang.statistics :runtime
    :erlang.statistics :wall_clock
    
    val = func.()
    {_, time1} = :erlang.statistics :runtime
    {_, time2} = :erlang.statistics :wall_clock
    [runtime: time1, wall_clock: time2, return_val: val]
  end

  def sleep(time) do
    receive do
    after time -> true
    end
  end
end

