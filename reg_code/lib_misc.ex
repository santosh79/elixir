defmodule LibMiscTest do
  def test_on_exit do
    pid = spawn(fn() ->
      receive do
        x -> List.to_atom x
      end
    end)

    LibMisc.on_exit pid, fn(why) ->
      IO.puts "here"
      :io.format("process ~p died with exit reason ~p ~n", [pid, why])
      # :io.format("process ~p died ~n", [pid])
    end

    send_bad_arg pid
  end
  
  def send_bad_arg(pid) do
    send pid, :bad_arg
  end
end

defmodule LibMisc do

  @doc """
  Link a bunch of functions together,
  so that if any of them die, all of them die
  """
  def start(funcs) do
    spawn(fn() ->
      for func <- funcs, do: spawn_link(func)
    end)
  end

  def on_exit(pid, func) do
    spawn(fn() ->
      ref = :erlang.monitor(:process, pid)
      receive do
        # {'DOWN', ^ref, :process, ^pid, why} ->
        {_, ^ref, :process, ^pid, why} ->
          apply func, [why]
      end
    end)
  end

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

