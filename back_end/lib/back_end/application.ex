defmodule BackEnd.Application do
  @moduledoc """
  Application to serve surveys.
  """

  use Application
  alias BackEnd.Endpoint

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:back_end, :cowboy_port)
    # List all child processes to be supervised
    children = [
      {Endpoint, [port: port]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BackEnd.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
