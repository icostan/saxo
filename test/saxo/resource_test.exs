defmodule Saxo.ResourceTest do
  use ExUnit.Case, async: true

  alias NimbleOptions.ValidationError
  @credentials %Saxo.Credentials{bearer: "ABCD"}

  defmodule TestResource do
    @moduledoc false
    use Saxo.Resource

    def_resource(
      :test,
      "/test/{p1}",
      "docs",
      p1: [type: :string, required: true],
      l1: [type: {:list, {:in, [:l1, :l2]}}],
      other: [type: :integer]
    )
  end

  describe "params validation" do
    test "missing required param" do
      assert {:error, %ValidationError{message: "required" <> _}} =
               TestResource.test(@credentials, [])
    end

    test "invalid required params" do
      assert {:error, %ValidationError{message: "invalid value" <> _}} =
               TestResource.test(@credentials, p1: true)
    end

    test "valid required params" do
      Req.Test.stub(HttpClientStub, fn conn ->
        Req.Test.json(conn, %{"ok" => true})
      end)

      assert {:ok, %Saxo.Response{status: 200, body: %{"ok" => true}}} =
               TestResource.test(@credentials, p1: "p1")
    end

    test "invalid params" do
      assert {:error, %ValidationError{message: "invalid value for :other option" <> _}} =
               TestResource.test(@credentials, p1: "p1", other: "INVALID")
    end
  end

  describe "params preparation" do
    test "split path and query params" do
      Req.Test.stub(HttpClientStub, fn conn ->
        assert %{"other" => "1"} = conn.query_params
        # assert %{"p1" => "p1"} = conn.path_params
        assert "/sim/openapi/test/pp" == conn.request_path
        Req.Test.json(conn, %{"ok" => true})
      end)

      assert {:ok, %Saxo.Response{status: 200, body: %{"ok" => true}}} =
               TestResource.test(@credentials, p1: "pp", other: 1)
    end

    test "join list params" do
      Req.Test.stub(HttpClientStub, fn conn ->
        assert %{"l1" => "l1,l2"} = conn.query_params
        Req.Test.json(conn, %{"ok" => true})
      end)

      assert {:ok, %Saxo.Response{status: 200, body: %{"ok" => true}}} =
               TestResource.test(@credentials, p1: "p1", l1: [:l1, :l2])
    end
  end
end
