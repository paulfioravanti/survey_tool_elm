defmodule BackEnd.Endpoint do
  @moduledoc """
  Endpoint to kick off a Cowboy server.
  """

  alias __MODULE__, as: Endpoint
  alias BackEnd.Router
  alias Plug.Cowboy

  @doc """
  This function called by `Supervisor.start_link/2`
  """
  def start_link(opts) do
    {:ok, _} = Cowboy.http(Router, [], opts)
  end

  @doc """
  Child spec definition allows this endpoint to be
  put under a supervision tree.
  """
  def child_spec(opts) do
    %{
      id: Endpoint,
      restart: :permanent,
      shutdown: 500,
      start: {Endpoint, :start_link, [opts]},
      type: :worker
    }
  end
end
