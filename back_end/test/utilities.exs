defmodule Utilities do
  def read_json(path) do
    path
    |> Path.expand()
    |> File.read!()
    |> Poison.Parser.parse!()
    |> Poison.encode!()
  end
end
