case IO.gets("Name: ") do
  {:error, reason} ->
    raise reason
  :eof -> raise "Hit eof"
  name ->
    IO.puts "Hey #{name}"
end

