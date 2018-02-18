defmodule Blockchain.Integrity do
  require Logger
  alias __MODULE__
  alias Blockchain.Block
  alias Blockchain.Chain

  @moduledoc """
  Integrity of Blockchain
  """

  @typedoc """
  Block Type
  """
  @type block :: Blockchain.Block

  @doc """
  The function add_hash expect a Block with argument, return a Block with hash
  """
  def valid_blockchain(blockchain) when length(blockchain) <= 1 do
    true
  end

  def valid_blockchain(blockchain) do
    [ current_block | tail ] = Enum.reverse(blockchain)
    [ previous_block | _] = tail

    cond do
      current_block.hash != Block.generate_hash(current_block) -> false
      current_block.index != previous_block.index + 1 -> false
      current_block.previous_hash != previous_block.hash -> false
      true -> true
    end

    Integrity.valid_blockchain(Enum.reverse(tail))
  end
end
