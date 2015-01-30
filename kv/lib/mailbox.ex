defmodule Mailbox do
  def check_mail do
    receive do
      x -> x
    end
  end
end


