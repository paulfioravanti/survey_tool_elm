defmodule RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias SurveyServer.Router

  @opts Router.init([])
  @json_resp_type ["application/json; charset=utf-8"]

  setup(%{method: method, path: path}) do
    conn =
      conn(method, path)
      |> Router.call(@opts)

    {:ok, [conn: conn]}
  end

  describe "GET /survey_results" do
    setup do
      json = Utilities.read_json("lib/survey_server/survey_results/index.json")
      {:ok, [json: json]}
    end

    @tag method: :get, path: "/survey_results"
    test "returns the survey index JSON", %{conn: conn, json: json} do
      assert conn.status == 200
      assert get_resp_header(conn, "content-type") == @json_resp_type
      assert conn.resp_body == json
    end
  end

  describe "GET /survey_results/:id" do
    setup do
      json = Utilities.read_json("lib/survey_server/survey_results/1.json")
      {:ok, [json: json]}
    end

    @tag method: :get, path: "/survey_results/1"
    test "returns the survey detail JSON for :id", %{conn: conn, json: json} do
      assert conn.status == 200
      assert get_resp_header(conn, "content-type") == @json_resp_type
      assert conn.resp_body == json
    end
  end

  describe "GET /survey_results/:id when :id is not found" do
    setup do
      json = Poison.encode!(%{error: "Record not found"})
      {:ok, [json: json]}
    end

    @tag method: :get, path: "/survey_results/9000"
    test "returns an error JSON object", %{conn: conn, json: json} do
      assert conn.status == 404
      assert get_resp_header(conn, "content-type") == @json_resp_type
      assert conn.resp_body == json
    end
  end

  describe "GET unknown path" do
    setup do
      json = Poison.encode!(%{error: "Not found"})
      {:ok, [json: json]}
    end

    @tag method: :get, path: "/unknown_path"
    test "returns an error JSON object", %{conn: conn, json: json} do
      assert conn.status == 404
      assert get_resp_header(conn, "content-type") == @json_resp_type
      assert conn.resp_body == json
    end
  end
end
