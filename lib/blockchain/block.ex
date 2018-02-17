defmodule Blockchain.Block do
  @moduledoc """
  # Block

  This module define the block struct and functions

  ### Block Structure
    - Index
    - Data
    - Timestamp
    - Previous Hash
    - Hash
  """

  @typedoc """
  Block Type
  """
  @type block :: __MODULE__

  defstruct index: 0,
            data: "Genesis block",
            timestamp: DateTime.utc_now,
            previous_hash: nil,
            hash: nil

  @doc """
  The function add_hash expect a Block with argument, return a Block with hash
  """
  @spec add_hash(block) :: block
  def add_hash(block) do
    %{block | hash: generate_hash(block)}
  end

  @doc """
  Generated hash with Block datas
  """
  @spec generate_hash(block) :: block
  defp generate_hash(block) do
    hash = :crypto.hash(:sha256, Enum.join [
      block.index,
      block.data,
      block.timestamp,
      block.previous_hash
    ])

    Base.encode64(hash)
  end
end
