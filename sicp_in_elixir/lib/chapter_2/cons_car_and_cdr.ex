defmodule ConsCarAndCdr do
  def cons(a, b) do
    fn(option) ->
      case option do
        :car      -> a
        :cdr      -> b
        :is_pair? -> true
      end
    end
  end

  def car(x), do: x.(:car)
  def cdr(x), do: x.(:cdr)

  def list_ref(items, n) do
    list_ref items, n, 0
  end
  defp list_ref(l, n, n), do: car(l)
  defp list_ref(nil, _, _), do: nil
  defp list_ref(l, n, cnt) do
    list_ref cdr(l), n, (cnt + 1)
  end

  def length(list), do: list_length(list, 0)
  defp list_length(nil, acc), do: acc
  defp list_length(list, acc) do
    list_length cdr(list), (acc + 1)
  end

  def list([h]), do: cons(h, nil)
  def list([h|t]) do
    cons(h, list(t))
  end

  def to_ex_list(l) do
    to_ex_list l, []
  end
  defp to_ex_list(nil, acc) do
    acc |> :lists.reverse
  end
  defp to_ex_list(l, acc) do
    to_ex_list cdr(l), [car(l)|acc]
  end

  @doc ~S"""
  Takes two lists as arguments and returns an appended,
  version of them.

  ###Example:
    
      append list([1,2,3]), list([4,5,6]) 
  Will return something that is equivalent to:

      list([1,2,3,4,5,6])
  """
  def append(list_one, list_two) do
    append list_one, list_two, []
  end
  defp append(nil, nil, acc) do
    acc |> :lists.reverse |> list
  end
  defp append(nil, list_two, acc) do
    append nil, cdr(list_two), [car(list_two)|acc]
  end
  defp append(list_one, list_two, acc) do
    append cdr(list_one), list_two, [car(list_one)|acc]
  end

  @doc ~S"""
  Returns the last element in the list.
  ###Example:
    last_pair(list(1,2,3,4)) == 4
  """
  def last_pair(l),          do: last_pair(l, nil)
  defp last_pair(nil, prev), do: prev
  defp last_pair(l, prev)    do
    last_pair cdr(l), car(l)
  end

  @doc ~S"""
  Takes a list as an argument and returns it's reverse.

  ### Example

      [1,2,3,4] |> list |> reverse

  Would be the same as

      [1,2,3,4] |> :lists.reverse > list
  """
  def reverse(l),         do: reverse(l, [])
  defp reverse(nil, acc), do: acc |> list
  defp reverse(l, acc)    do
    reverse cdr(l), [car(l)|acc]
  end

  @doc ~S"""
  Utility method that confirms if the argument passed in is a
  cons pair.
  ### Example:
      cons(1,2) |> is_pair? #true
  """
  def is_pair?(l) do
    try do
      l.(:is_pair?)
    rescue
      _ -> false
    end
  end
end

