defmodule Saxo.ReferenceData.InstrumentsTest do
  use ExUnit.Case, async: true

  alias Saxo.ReferenceData.Instruments

  @credentials %Saxo.Credentials{bearer: "ABCD"}

  describe ".get_futures_space/1" do
    test "missing required param" do
      assert_raise NimbleOptions.ValidationError, ~r/required/, fn ->
        Instruments.futures_space(@credentials, [])
      end
    end

    test "invalid required params" do
      assert_raise NimbleOptions.ValidationError, ~r/invalid value/, fn ->
        Instruments.futures_space(@credentials, ContinuousFuturesUic: "INVALID")
      end
    end
  end
end
