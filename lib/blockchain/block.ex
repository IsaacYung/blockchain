defmodule Blockchain.Block do
  defstruct index: 0,
            data: "Genesis block",
            timestamp: DateTime.utc_now,
            previous_hash: nil,
            hash: nil

  def add_hash(block) do
    %{block | hash: generate_hash(block)}
  end

  defp generate_hash(block) do
    :crypto.hash(:sha256, Enum.join [
      block.index,
      block.data,
      block.timestamp,
      block.previous_hash
    ])
    |> Base.encode64
  end
end
