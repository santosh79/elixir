defmodule AreaServer do
  def start do
    pid = spawn(AreaServer, :loop, [])
    try do
      Process.register pid, :area_server
    rescue 
      _ ->
        IO.puts "killing it"
        send pid, :stop
    end
  end

  def calc(request = {:rectangle, wd, ht}), do: rpc request
  def calc(request = {:square, sd}),        do: rpc request
  def calc(request = {:circle, r}),         do: rpc request

  defp rpc(request) do
    server = Process.whereis :area_server
    rpc server, request
  end

  defp rpc(nil, _request), do: {:error, "Area server not running"}
  defp rpc(pid, request) do
    send pid, {self, request}
    receive do
      {_s, area} -> {:ok, area}
    end
  end

  def loop do
    receive do
      {from, {:rectangle, wd, ht}} ->
        send from, {self, (wd * ht)}
        loop
      {from, {:square, side}} ->
        send from, {self, (side * side)}
        loop
      {from, {:circle, radius}} ->
        send from, {self, (:math.pi * radius * radius)}
        loop
      {from, bad_message} ->
        send from, {self, {:error, bad_message}}
        loop
      :stop -> :void
    end
  end
end

