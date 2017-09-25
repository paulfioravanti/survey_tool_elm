defmodule SurveyServer.Encoder do
  @moduledoc """
  Module responsible for encoding strings into JSON objects.
  """

  @doc """
  Parse and encode string into a JSON object.
  """
  def encode_json(string) do
    string
    |> Poison.Parser.parse!()
    |> Poison.encode!()
  end

  @doc """
  Encode `message` into a JSON object.
  """
  def json_error(message) do
    %{error: message}
    |> Poison.encode!()
  end
end
