defmodule Scraper do
  def scrape(base_url) do
    response = :httpc.request String.to_char_list(base_url)
    IO.puts "response is #{response}"
  end
end

