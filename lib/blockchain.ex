defmodule Blockchain do
  require Logger
  alias Blockchain.Block
  alias Blockchain.Chain
  alias Blockchain.Integrity
  @moduledoc """
  Documentation for Blockchain.
  """

  def genesis_block(pid \\ Chain) do
    %Block{index: 1}
    |> Block.add_hash
    |> Chain.enqueue(pid)
  end

  def last_block(pid \\ Chain) do
    Chain.queue(pid)
    |> List.last
  end

  def add_block(data, pid \\ Chain) do
    block = last_block()

    %Block{data: data, index: block.index + 1, previous_hash: block.hash}
    |> Block.add_hash
    |> Chain.enqueue(pid)
  end

  def start_link do
    Logger.warn "Initialize Blockchain"
    genesis_block()
    add_block("Genesis block2")
    add_block("amount: 100")
    add_block("amount: 200")
    add_block("amount: 300")

    IO.inspect Chain.queue
    IO.puts Integrity.valid_blockchain(Chain.queue)
  end
end
