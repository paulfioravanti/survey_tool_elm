defmodule SurveyServer.Router do
  @moduledoc """
  Simple router for survey server.  Serves up static JSON files, but goes
  and fetches/reads them in every time since under production conditions
  it is assumed that different requests to get survey results would return
  different data.
  """

  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  # NOTE: By default, Cowboy makes a request to find a favicon, and errors
  # if it's missing, so provide one.
  plug Plug.Static,
    at: "/",
    from: :survey_server,
    gzip: false,
    only: ~w(favicon.ico)
  plug :match
  plug :dispatch

  get "/survey_results" do
    "survey_results/index.json"
    |> read_file()
    |> send_response(conn)
  end

  get "/survey_results/:id" do
    "survey_results/#{id}.json"
    |> read_file()
    |> send_response(conn)
  end

  get "/*path" do
    send_error(conn, "Not found")
  end

  defp read_file(path) do
    path
    |> Path.expand(__DIR__)
    |> File.read()
  end

  # NOTE: File was found.
  defp send_response({:ok, content}, conn) do
    json = encode_json(content)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json)
  end
  # NOTE: File was not found.
  defp send_response({:error, :enoent}, conn) do
    send_error(conn, "Record not found")
  end

  defp encode_json(string) do
    string
    |> Poison.Parser.parse!()
    |> Poison.encode!()
  end

  defp send_error(conn, message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Poison.encode!(%{error: message}))
  end
end
