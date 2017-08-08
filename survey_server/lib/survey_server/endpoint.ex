defmodule SurveyServer.Endpoint do
  @moduledoc """
  Endpoint to kick off a Cowboy server.
  """

  alias __MODULE__, as: Endpoint

  @doc """
  This function called by `Supervisor.start_link/2`
  """
  def start_link(_args) do
    {:ok, _} = Plug.Adapters.Cowboy.http(SurveyServer.Router, [])
  end

  @doc """
  Child spec definition allows this endpoint to be
  put under a supervision tree.
  """
  def child_spec(opts) do
    %{
      id: Endpoint,
      start: {Endpoint, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end
end
