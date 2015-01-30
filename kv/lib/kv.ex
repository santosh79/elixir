defmodule KV do
  def start do
    Process.register spawn(KV, :loop, []), :kv
  end

  def lookup(key) do
    rpc {:lookup, key}
  end

  def store(key, val) do
    rpc {:store, key, val}
  end

  def rpc(msg) do
    kv = Process.whereis :kv
    send kv, {self, msg}
  end

  def loop do
    receive do
      {from, {:lookup, key}} ->
        send from, Process.get(key)
        loop
      {from, {:store, key, val}} ->
        Process.put key, val
        send from, :ok
        loop
    end
  end
end


