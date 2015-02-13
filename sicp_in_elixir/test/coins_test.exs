defmodule CoinsTest do
  use ExUnit.Case

  test "with just one type of coins" do
    assert Coins.get_breakdown(100, [1]) == 1
  end

  test "normal way" do
    us_coins = [1, 5, 10, 25, 50] 
    uk_coins = [100, 50, 20, 10, 5, 2, 1, 0.5]
    assert Coins.get_breakdown(100, us_coins) == 292
    assert Coins.get_breakdown(100, uk_coins) == 4563
  end

  test "with no way of breaking down" do
    assert Coins.get_breakdown(100, [3]) == 0
  end
end
