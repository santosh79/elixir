defmodule Assertions do
  defmacro assert(operator, _ , [lhs, rhs]) do
    quote do
      do_assert unquote(operator),
                unquote(lhs),
                unquote(rhs)
    end
  end


  def do_assert(:>=, lhs, rhs)  when lhs >= rhs,  do: print_success
  def do_assert(:>=, lhs, rhs), do: print_fail(lhs, rhs, "to be greater than or equal to")

  def do_assert(:>, lhs, rhs)  when lhs > rhs,  do: print_success
  def do_assert(:>, lhs, rhs), do: print_fail(lhs, rhs, "to be greater than")

  def do_assert(:==, lhs, rhs)  when lhs == rhs,  do: print_success
  def do_assert(:==, lhs, rhs), do: print_fail(lhs, rhs, "to be equal to")

  def do_assert(:===, lhs, rhs) when lhs === rhs, do: print_success
  def do_assert(:===, lhs, rhs), do: print_fail(lhs, rhs, "to be equal to")

  defp print_success, do: IO.write(".")

  defp print_fail(lhs, rhs, fail_message) do
    IO.puts """
    FAIL: Expected: #{lhs}
    #{fail_message}: #{rhs}
    """
  end
end

