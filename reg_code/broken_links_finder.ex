defmodule BrokenLinksFinder do
  alias UrlChecker
  import UrlChecker, only: [is_working_url: 1]

  def find_broken_links_serial(urls) when is_list(urls) do
    urls
    |> Enum.reject(fn(url) -> is_working_url(url) end)
  end

  def find_broken_links(urls) when is_list(urls) do
  end
end

