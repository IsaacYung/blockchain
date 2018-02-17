defmodule BlockchainSupervisor do
  def start(status, opts) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Blockchain.Chain, []),
      supervisor(Blockchain, [])
    ]

    opts = [strategy: :one_for_one, name: Blockchain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
