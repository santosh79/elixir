defmodule TowersOfHanoi.Tower do
  def test do
    tower_one = start :tower_one

    vals = [100, 100_000, 1_000, 10_000]
    vals |> Enum.each(fn(val) -> add(tower_one, val) end)
    sorted_tower_one = tower_one |> get_elements |> Enum.sort
    sorted_vals      = vals |> Enum.sort
    ^sorted_vals     = sorted_tower_one
  end

  def start(name, tires \\ []) do
    spawn __MODULE__, :loop, [name, tires]
  end

  def print_elements(pid) do
    send pid, {self, :print_elements}
    receive_ok pid
  end

  def get_elements(pid) do
    send pid, {self, :get_elements}
    receive do
      {^pid, {_name, tires}} -> tires
    end
  end

  def pop(pid) do
    send pid, {self, :pop}
    receive do
      {^pid, val} -> val
    end
  end

  def add(pid, val) do
    send pid, {self, {:push, val}}
    receive_ok pid
  end

  defp receive_ok(pid) do
    receive do
      {^pid, :ok} -> :ok
    end
  end

  def loop(name, tires) do
    receive do
      {sender, :pop} ->
        case tires do
          [] ->
            send sender, {self, nil}
          [h|t] ->
            send sender, {self, h}
            tires = t
        end
      {sender, {:push, val}} ->
        tires = [val|tires]
        send sender, {self, :ok}
      {sender, :get_elements} ->
        send sender, {self, {name, tires}}
      {sender, :print_elements} ->
        IO.puts "#{name}: #{inspect tires}"
        send sender, {self, :ok}
    end
    loop name, tires
  end
end

defmodule TowersOfHanoiWithProcesses do
  import TowersOfHanoi.Tower
  def move(number_of_tires) do

    from  = start :from
    to    = start :to
    spare = start :spare

    number_of_tires..1 |> Enum.each fn(num) ->
      add from, num
    end

    IO.puts "Getting started:"
    [from, to, spare] |> Enum.each fn(tower) ->
      print_elements tower
    end
    move number_of_tires, from, to, spare
  end

  defp move(1, from, to, spare) do
    el = pop from
    add to, el

    IO.puts "------------"
    print_towers from, to, spare
  end
  defp move(number_of_tires, from, to, spare) do
    move (number_of_tires - 1), from, spare, to
    move 1, from, to, spare
    move (number_of_tires - 1), spare, from, to
    move (number_of_tires - 1), from, to, spare
  end

  defp print_towers(from, to, spare) do
    [from, to, spare] |> Enum.each(&( &1 |> print_elements ))
  end
end

