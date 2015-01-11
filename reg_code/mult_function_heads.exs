some_func = fn
  {:a, args} -> IO.puts "got a with #{args}"
  {:b, args} -> IO.puts "got b with #{args}"
end

some_func.({:b, "foo"})
