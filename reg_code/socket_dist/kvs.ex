defmodule Kvs do
  def test do
    Kvs.start
    Kvs.store :foo, 10

    {:ok, 10} = Kvs.lookup :foo
  end

  def start do
    Process.register(spawn(Kvs, :loop, []), :kvs)
  end

  def store(key, val), do: rpc({:store, key, val})
  def lookup(key),     do: {:ok, rpc({:lookup, key})}

  def rpc(request) do
    pid = Process.whereis :kvs
    send pid, {self, request}
    receive do
      {pid, response} -> response
    end
  end

  def loop do
    receive do
      {from, {:lookup, key}} ->
        send from, {self, Process.get(key)}
        loop
      {from, {:store, key, val}} ->
        send from, {self, Process.put(key, val)}
        loop
    end
  end
end

