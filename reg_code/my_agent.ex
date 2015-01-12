defmodule MyAgent do
  def start_link(func, args \\[]) do
    ds = apply func, args
    pid = spawn_link MyAgent, :loop, ds
  end

  def loop(ds) do
    receive do
    end
  end
end

