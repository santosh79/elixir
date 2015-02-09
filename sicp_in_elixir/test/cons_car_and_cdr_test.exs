defmodule ConsCarAndCdrTest do
  use ExUnit.Case
  import ConsCarAndCdr

  test "simple test" do
    a = cons(10, 20)
    assert car(a) == 10
    assert cdr(a) == 20
  end

end
