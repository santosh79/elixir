defmodule Converter do
  alias :math, as: Math
  import Math, only: [pi: 0] 

  def get_pi do
    pi
  end
end

IO.puts Converter.get_pi
