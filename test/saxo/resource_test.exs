defmodule Saxo.ResourceTest do
  use ExUnit.Case, async: true

  @credentials %Saxo.Credentials{bearer: "ABCD"}

  defmodule TestResource do
    @moduledoc false
    use Saxo.Resource

    def_resource(
      :test,
      "/test/{p1}",
      "docs",
      p1: [type: :string, required: true],
      other: [type: :integer]
    )
  end

  describe "params validation" do
    test "missing required param" do
      assert_raise NimbleOptions.ValidationError, ~r/required/, fn ->
        TestResource.test(@credentials, [])
      end
    end

    test "invalid required params" do
      assert_raise NimbleOptions.ValidationError, ~r/invalid value/, fn ->
        TestResource.test(@credentials, p1: true)
      end
    end

    test "valid required params" do
      Req.Test.stub(HttpClientStub, fn conn ->
        Req.Test.json(conn, %{"ok" => true})
      end)

      assert {:ok, %Saxo.Response{status: 200, body: %{"ok" => true}}} =
               TestResource.test(@credentials, p1: "p1")
    end

    test "invalid params" do
      assert_raise NimbleOptions.ValidationError, ~r/invalid value/, fn ->
        TestResource.test(@credentials, p1: "p1", other: "INVALID")
      end
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
  end
end
