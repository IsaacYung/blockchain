defmodule Blockchain.MixProject do
  use Mix.Project

  def project do
    [
      app: :blockchain,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: Coverex.Task]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Supervisor, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.2"},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:exsync, "~> 0.2", only: :dev},
      {:coverex, "~> 1.4", only: [:test, :dev]},
      {:credo, "~> 0.8", only: [:dev, :test]}
    ]
  end
end
