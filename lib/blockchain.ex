defmodule Blockchain do
  require Logger
  alias Blockchain.Block
  alias Blockchain.Chain
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

  def add_block(pid \\ Chain) do
    block = last_block()

    %Block{index: block.index + 1, previous_hash: block.hash}
    |> Block.add_hash
    |> Chain.enqueue(pid)
  end

  def start_link do
    Logger.warn "Initialize Blockchain"
    genesis_block()
    add_block
    add_block()
    add_block()
    add_block()
    IO.inspect last_block()
    IO.inspect Chain.queue
  end
end
