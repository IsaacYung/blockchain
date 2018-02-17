defmodule Blockchain.Chain do
  require Logger
  use GenServer
  @moduledoc """
  Chain of blockchain, responsable for share the queue state
  """

  @doc """
  GenServer.init/1 callback
  """
  def init(state) do
    Logger.warn "Initialize Chain"
    {:ok, state}
  end

  @doc """
  GenServer.handle_call/3 callback
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API / Helper functions

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue(pid \\ __MODULE__), do: GenServer.call(pid, :queue)
  def enqueue(value, pid \\ __MODULE__), do: GenServer.cast(pid, {:enqueue, value})
  def dequeue(pid \\ __MODULE__), do: GenServer.call(pid, :dequeue)
end
