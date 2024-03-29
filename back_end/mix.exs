defmodule BackEnd.Mixfile do
  use Mix.Project

  def project do
    [
      app: :back_end,
      version: "0.1.0",
      elixir: "~> 1.15",
      build_embedded: Mix.env() == :prod,
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
      {:cors_plug, "~> 3.0"},
      {:cowboy, "~> 2.10"},
      {:mix_test_watch, "~> 1.1", only: :dev, runtime: false},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"}
    ]
  end
end
