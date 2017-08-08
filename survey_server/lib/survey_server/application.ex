defmodule SurveyServer.Application do
  @moduledoc """
  Application to serve surveys.
  """

  use Application

  @impl true
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {SurveyServer.Endpoint, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurveyServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
