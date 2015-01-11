defmodule MultFunctionHeads do
  def test do
    some_func = fn
      {:a, args} -> IO.puts "got a with #{args}"
      {:b, args} -> IO.puts "got b with #{args}"
    end
  end
end

