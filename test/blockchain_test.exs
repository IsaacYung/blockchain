defmodule BlockchainTest do
  require Logger
  use ExUnit.Case
  doctest Blockchain

  setup do
    {:ok, server_pid} = Blockchain.Chain.start_link
    {:ok, server: server_pid}
  end

  test "genesis_block", state do
    Blockchain.genesis_block(state[:server])

    genesis_block = List.first Blockchain.Chain.queue

    assert genesis_block.index == 1
    assert genesis_block.data == "Genesis block"
    assert genesis_block.timestamp != nil
    assert genesis_block.previous_hash == nil
    assert genesis_block.hash == "n7jW7VSaq9D73sIDlceaPMPofpJFUFB8Ws/tl6X+tIU="
  end

  test "verify block cosistence when add a new block", state do
    Blockchain.genesis_block(state[:server])
    Blockchain.add_block("Genesis block", state[:server])

    new_block = Blockchain.last_block

    assert new_block.index == 2
    assert new_block.data == "Genesis block"
    assert new_block.timestamp != nil
    assert new_block.previous_hash == "n7jW7VSaq9D73sIDlceaPMPofpJFUFB8Ws/tl6X+tIU="
    assert new_block.hash == "PnQ6Fu9PLpcLE+K1wxwpPh8Vu5zsgzU8tG6y3TBtV4g="
  end
end
