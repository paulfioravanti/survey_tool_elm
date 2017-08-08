defmodule SurveyServer.Application do
  @moduledoc """
  Application to serve surveys.
  """

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:survey_server, :cowboy_port)
    # List all child processes to be supervised
    children = [
      {SurveyServer.Endpoint, [port: port]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurveyServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
