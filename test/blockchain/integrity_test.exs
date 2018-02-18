defmodule Blockchain.IntegrityTest do
  use ExUnit.Case
  doctest Blockchain
  alias Blockchain.Chain
  alias Blockchain.Integrity

  setup do
    {:ok, server_pid} = Chain.start_link
    {:ok, server: server_pid}
  end

  test "when integrity of blockchain is true", state do
    Blockchain.genesis_block(state[:server])
    Blockchain.add_block("Genesis block 1", state[:server])
    Blockchain.add_block("Genesis block 2", state[:server])
    Blockchain.add_block("Genesis block 3", state[:server])
    Blockchain.add_block("Genesis block 4", state[:server])
    Blockchain.add_block("Genesis block 5", state[:server])

    assert Integrity.valid_blockchain(Chain.queue) == true
  end

  test "when integrity of blockchain is false", state do
    Blockchain.genesis_block(state[:server])
    Blockchain.add_block("Genesis block 1", state[:server])
    Blockchain.add_block("Genesis block 2", state[:server])
    Blockchain.add_block("Genesis block 3", state[:server])
    Blockchain.add_block("Genesis block 4", state[:server])
    Blockchain.add_block("Genesis block 5", state[:server])

    assert Integrity.valid_blockchain(Chain.queue) == false
  end
end
