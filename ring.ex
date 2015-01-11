# defmodule RingTester do
#   def test() do
#     number_nodes = 10_000
#     h = Ring.start number_nodes
#     IO.inspect h
#     send h, :hi
#     # wait_results number_nodes
#   end
#
#   defp wait_results(0), do: :done
#   defp wait_results(count) do
#     receive do
#       {_sender, :ok} -> wait_results(count - 1)
#     end
#   end
# end
#
defmodule Ring do

  def start(num_nodes) when num_nodes > 0 do
    pid = spawn(fn() ->
      head = start 0, num_nodes, []
      loop head
    end)
    Process.register pid, :ring_server
  end

  def running?, do: !!Process.whereis(:ring_server)

  def send_message(message) do
    pid = Process.whereis :ring_server
    send pid, message
  end

  def die do
    running? && send_message(:die)
  end

  def loop(head) do
    receive do
      :die ->
        Ring.Node.send_to_node head, :die
        IO.puts "server exiting.."
        :void
      message ->
        Ring.Node.send_to_node head, message
        loop head
    end
  end

  defp start(num_nodes, num_nodes, pids) do
    hd pids
  end

  defp start(count, num_nodes, []) do
    pid = spawn Ring.Node, :loop, []
    start (count+1), num_nodes, [pid]
  end

  defp start(count, num_nodes, pids) do
    prev_pid = hd pids
    pid = spawn Ring.Node, :loop, [prev_pid]
    start (count+1), num_nodes, [pid|pids]
  end

end

defmodule Ring.Node do
  def send_to_node(pid, msg) do
    send pid, {self, msg}
  end

  def loop() do
    receive do
      {_sender, :die} ->
        IO.inspect(self)
        IO.puts("exiting..")
        :void
      {_sender, message} ->
        IO.inspect(self)
        IO.puts("got message #{message}")
        loop
    end
  end

  def loop(prev) do
    receive do
      {_sender, :die} ->
        IO.inspect(self)
        IO.puts("exiting..")
        send_to_node prev, :die
        :void
      {_sender, message} ->
        IO.inspect(self)
        IO.puts("got message #{message}")
        send_to_node prev, message
        loop prev
    end
  end
end
