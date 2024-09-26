defmodule Saxo.ReferenceData.InstrumentsTest do
  use ExUnit.Case, async: true

  alias Saxo.ReferenceData.Instruments

  @credentials %Saxo.Credentials{bearer: "ABCD"}

  describe ".get_futures_space/1" do
    test "missing required param" do
      assert {:error, %NimbleOptions.ValidationError{message: "required" <> _}} =
               Instruments.futures_space(@credentials, [])
    end

    test "invalid required params" do
      assert {:error, %NimbleOptions.ValidationError{message: "invalid value" <> _}} =
               Instruments.futures_space(@credentials, ContinuousFuturesUic: "INVALID")
    end
  end
end
