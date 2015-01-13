defmodule LibMiscTest do
  defp sleep_5 do
    IO.puts "in sleep_5"
    LibMisc.Process.sleep_for 5
    IO.puts "done waiting for 5 seconds"
  end

  def test_my_spawn do
    LibMisc.Process.my_spawn LibMiscTest, :sleep_5, []
  end

  def test_on_exit do
    pid = spawn(fn() ->
      receive do
        x -> List.to_atom x
      end
    end)

    LibMisc.Process.capture_exit_msg pid

    sleep_5
    send_bad_arg pid
  end
  
  def send_bad_arg(pid) do
    send pid, :bad_arg
  end

  def test_start do
    func = fn ->
      :io.format("I am process ~p ~n", [self])
      LibMisc.Process.capture_exit_msg self
      LibMisc.Process.wait_forever
    end

    1..10_000
    |> Enum.map(fn(_x) -> func end)
    |> LibMisc.Process.start
  end
end

defmodule LibMisc.Process do
  @doc ~S"""
  Sets up an on_exit handler for `pid` and pretty-prints an
  error message as to why the process died.

  ## Examples
      pid = spawn(fn ->
        receive do
        after 5 * 1000 ->
          :ok
        end
      end)
      capture_exit_msg pid
  """
  def capture_exit_msg(pid) do
    on_exit pid, fn(why) ->
      :io.format("process ~p died with exit reason ~p ~n", [pid, why])
    end
  end

  @doc ~S"""
  Puts the current process, i.e. the process in whose 
  context this function is eval'ed, to sleep for `seconds`.

  ## Examples
      sleep_for 5
  """
  def sleep_for(seconds) do
    receive do
    after seconds * 1000 -> 
      :ok
    end
  end

  @doc ~S"""
  Link a bunch of functions together,
  so that if any of them die, all of them die

  ## Examples
      funcs = [&(&1 + 2), &(&1 + 3)]
      LibMisc.start funcs

  """
  def start(funcs) do
    main_pid = spawn(fn() ->
      funcs 
      |> Enum.each &(spawn_link(&1))

      wait_forever
    end)
  end

  @doc ~S"""
  Monitors a process with pid `pid`.
  If the process exits, for any reason, the callback `func`
  is called with the reason for the exit.

  ## Examples
      pid = spawn(fn ->
        receive do
          _x -> :void
        end
      end)

      LibMisc.on_exit pid, fn(why) ->
        :io.format("process with pid ~p exited due to ~p ~n", [pid, why])
      end
  """
  def on_exit(pid, func) do
    spawn(fn() ->
      ref = :erlang.monitor(:process, pid)
      receive do
        # {'DOWN', ^ref, :process, ^pid, why} ->
        {_, ^ref, :process, ^pid, why} ->
          IO.puts "got on exit"
          apply func, [why]
      end
    end)
  end

  def keep_alive(name, func) do
    pid = spawn func
    Process.register pid, name
    on_exit(pid, fn(_why) ->
      keep_alive name, func
    end)
  end

  def flush_buffer do
    receive do
      _any -> flush_buffer
    after 0 -> true
    end
  end

  def wait_forever do
    receive do
    end
  end

  def my_spawn(mod, func, args) do
    spawn fn ->
      {_, time1secs, time1} = :erlang.now
      time1_microsecs = time1secs * 1000 + time1
      main_pid = spawn mod, func, args
      on_exit(main_pid, fn(why) ->
        :io.format("process ~p died due to ~p ~n", [main_pid, why])
        {_, time2secs, time2} = :erlang.now
        time2_microsecs = time2secs * 1000 + time2
        IO.puts "It ran for #{time2_microsecs - time1_microsecs} micro-seconds"
      end)
    end
  end

  def sleep(time) do
    receive do
    after time -> true
    end
  end
end

defmodule LibMisc do

  def func_test(func) do
    spawn func
  end

  def time(func, args \\ []) do
    :erlang.statistics :runtime
    :erlang.statistics :wall_clock
    
    val = apply(func, args)
    {_, time1} = :erlang.statistics :runtime
    {_, time2} = :erlang.statistics :wall_clock
    [runtime: time1, wall_clock: time2, return_val: val]
  end
end

