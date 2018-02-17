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
  defstruct index: 0,
            data: "Genesis block",
            timestamp: DateTime.utc_now,
            previous_hash: nil,
            hash: nil

  @doc """
  The function add_hash expect a Block with argument, return a Block with hash
  """
  def add_hash(block) do
    %{block | hash: generate_hash(block)}
  end

  @doc """
  Generated hash with Block datas
  """
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
