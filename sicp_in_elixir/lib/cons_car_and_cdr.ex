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
  end

