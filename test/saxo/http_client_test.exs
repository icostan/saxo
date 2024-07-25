defmodule Saxo.HttpClientTest do
  use ExUnit.Case, async: true

  alias Saxo.{HttpClient, Response}

  describe ".get/2" do
    test "ok response" do
      Req.Test.stub(HttpClientStub, fn conn ->
        conn
        |> Req.Test.json(%{"ok" => true})
      end)

      assert {:ok, %Response{status: 200, body: %{"ok" => true}}} =
               HttpClient.get("/test", auth: "test", query: [])
    end

    test "error response" do
      plug = fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(400, ~s|{"error":true}|)
      end

      assert {:error, %Response{status: 400, body: %{"error" => true}}} =
               HttpClient.get("/test", auth: "test", query: [], plug: plug)
    end
  end
end
