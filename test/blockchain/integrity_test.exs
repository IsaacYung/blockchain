defmodule Blockchain.IntegrityTest do
  use ExUnit.Case
  doctest Blockchain
  alias Blockchain.Chain
  alias Blockchain.Integrity
  alias Blockchain.Block

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

    chain = Chain.queue
    fail_block = %Block{
      index: 9,
      data: "Genesis block attack",
      timestamp: "2018-02-17 18:07:39.770360Z",
      previous_hash: "Van0+JlLG78gWOo4yO+2xFkACBTV85wIcAJXFjnmIw4=",
      hash: "YDA64iuZiGG847KPM+7BvnWKITyGyTwHbb6fVYwRx1I="
    }

    fail_chain = chain ++ [fail_block]

    assert Integrity.valid_blockchain(fail_chain) == false
  end
end
