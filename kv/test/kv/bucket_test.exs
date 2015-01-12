defmodule BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by keys", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put bucket, "milk", 3
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes a key", %{bucket: bucket} do
    assert KV.Bucket.delete(bucket, :foo) == nil
    KV.Bucket.put bucket, :foo, "bar"
    assert KV.Bucket.delete(bucket, :foo) == "bar"
    assert KV.Bucket.delete(bucket, :foo) == nil
  end
end

