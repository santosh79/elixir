defmodule UrlChecker do
  def is_working_url(url) do
    case :httpc.request(String.to_char_list(url)) do
      {:error, _} -> false
      _           -> true
    end
  end
end

