defmodule Supervisor do
  import Application

  @moduledoc """
  # Main Supervisor of Blockchain

  This supervisor is responsable for the start and manteniment of blockchain
  """

  @doc """
  Start application supervisor

  children:
  Blockchain

  the strategy is one for one, for each process down create a new process
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Blockchain, [])
    ]

    opts = [strategy: :one_for_one, name: Supervisor.Blockchain]
    Supervisor.start_link(children, opts)
  end
end
