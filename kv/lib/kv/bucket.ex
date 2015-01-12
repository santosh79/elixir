defmodule KV.Bucket do
  @doc """
  Starts a new bucket.
  """
  def start_link do
    Agent.start_link(fn -> HashDict.new end)
  end

  @doc """
  Gets an item from the bucket
  """
  def get(bucket, item) do
    Agent.get(bucket, fn(map) -> Dict.get(map, item) end)
  end

  @doc """
  Puts an item from the bucket
  """
  def put(bucket, item, val) do
    Agent.update(bucket, fn(map) -> Dict.put(map, item, val) end)
  end

  @doc """
  Deletes an item from the bucket.
  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn(map) -> Dict.pop(map, key) end)
  end
end

