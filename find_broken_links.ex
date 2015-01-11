defmodule UrlChecker do 
  def check_urls(urls, sender_pid) when is_pid(sender_pid) do
    spawn fn() ->
      results = check_urls urls
      send sender_pid, results
    end
    :ok
  end

  def check_urls(urls) do
    working_url = fn(url) ->
      spawn UrlChecker, :works?, [self, url]
    end

    urls |> Enum.each(&working_url/1)
    get_results Enum.count(urls)
  end

  defp get_results(num), do: get_results(0, num, [])
  defp get_results(num, num, broken_links), do: {:ok, broken_links}

  defp get_results(cnt, num, broken_links) do
    receive do
      {_client, url, true}  -> get_results(cnt + 1, num, broken_links)
      {_client, url, false} -> get_results(cnt + 1, num, [url|broken_links])
    end
  end
end


