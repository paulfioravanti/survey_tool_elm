defmodule BackEnd.Mixfile do
  use Mix.Project

  def project do
    [
      app: :back_end,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {BackEnd.Application, []}
    ]
  end

  defp deps do
    [
      {:cors_plug, "~> 1.5"},
      {:cowboy, "~> 1.1"},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
      {:plug, "~> 1.5"},
      {:poison, "~> 3.1"}
    ]
  end
end
