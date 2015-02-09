  defmodule ConsCarAndCdr do
    def cons(a, b) do
      fn(option) ->
        case option do
          :car -> a
          :cdr -> b
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

    def list([h]), do: cons(h, nil)
    def list([h|t]) do
      cons(h, list(t))
    end
  end

