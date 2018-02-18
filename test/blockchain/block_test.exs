defmodule Blockchain.BlockTest do
  use ExUnit.Case
  alias Blockchain.Block
  doctest Blockchain.Block

  setup_all do
    block = %Block{
      index: 1,
      data: "Genesis block",
      timestamp: "2018-02-17 18:07:39.770360Z",
      previous_hash: "Van0+JlLG78gWOo4yO+2xFkACBTV85wIcAJXFjnmIw4=",
      hash: "YDA64iuZiGG847KPM+7BvnWKITyGyTwHbb6fVYwRx1I="
    }

    {:ok, block: block}
  end

  test "struct of block", state do
    assert state[:block].index == 1
    assert state[:block].data == "Genesis block"
    assert state[:block].timestamp == "2018-02-17 18:07:39.770360Z"
    assert state[:block].previous_hash == "Van0+JlLG78gWOo4yO+2xFkACBTV85wIcAJXFjnmIw4="
    assert state[:block].hash == "YDA64iuZiGG847KPM+7BvnWKITyGyTwHbb6fVYwRx1I="
  end

  test "creation of block", state do
    new_block = %{state[:block] | hash: nil}
    full_block = Block.add_hash new_block

    assert full_block.hash == "+vCPJqFIRfvVqtbR0dvIiUj0Oe2OG6hiDPI4YUB2DR8="
  end
end
