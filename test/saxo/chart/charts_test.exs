defmodule Saxo.Chart.ChartsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  alias Saxo.Credentials
  alias Saxo.Chart.Charts

  @uic 21
  @asset_type :FxSpot
  @horizon 1440
  @bearer "eyJhbGciOiJFUzI1NiIsIng1dCI6IjI3RTlCOTAzRUNGMjExMDlBREU1RTVCOUVDMDgxNkI2QjQ5REEwRkEifQ.eyJvYWEiOiI3Nzc3NSIsImlzcyI6Im9hIiwiYWlkIjoiMTA5IiwidWlkIjoiM2ozaVkzeFNFRGRmM0M5bXo2cld1Zz09IiwiY2lkIjoiM2ozaVkzeFNFRGRmM0M5bXo2cld1Zz09IiwiaXNhIjoiRmFsc2UiLCJ0aWQiOiIyMDAyIiwic2lkIjoiYTAzNjRlMDJjMmViNGI5N2EwZTMzNTY2YjRmZjE2NDgiLCJkZ2kiOiI4NCIsImV4cCI6IjE3MjAzMzQxMDkiLCJvYWwiOiIxRiIsImlpZCI6IjRlYjc5NTBmZWU0ZTQ3OWQ0M2Q2MDhkYzUzZGFjZDg3In0.u425MqBj088_oPpsxbDYdjAkYa18iqR3qkJSeNKO-JOa3I76tIDGkfkgDYaPWpQ01Q3sOLTTD2jjftIzh_XQ5w"

  setup do
    %{credentials: %Credentials{bearer: @bearer}}
  end

  describe ".get/5" do
    test "EURUSD spot", %{credentials: credentials} do
      use_cassette("get EURUSD spot") do
        assert {:ok, response} =
                 Charts.get(credentials, @asset_type, @uic, @horizon,
                   count: 1,
                   field_groups: [:ChartInfo, :Data, :DisplayAndFormat],
                   mode: :From,
                   time: "2024-04-08"
                 )

        assert 200 = response.status

        assert %{
                 "ChartInfo" => %{
                   "DelayedByMinutes" => 0,
                   "ExchangeId" => "SBFX",
                   "FirstSampleTime" => _,
                   "Horizon" => 1440
                 },
                 "Data" => [%{"CloseAsk" => 1.08604, "CloseBid" => 1.08584}],
                 "DataVersion" => 1_976_175_155,
                 "DisplayAndFormat" => %{
                   "Currency" => "USD",
                   "Decimals" => 4,
                   "Description" => "Euro/US Dollar",
                   "Format" => "AllowDecimalPips",
                   "Symbol" => "EURUSD"
                 }
               } = response.body
      end
    end

    test "invalid instrument", %{credentials: credentials} do
      use_cassette("get invalid instrument") do
        assert {:error, response} =
                 Charts.get(credentials, @asset_type, "INVALID", @horizon, count: 1)

        assert 400 = response.status

        assert %{
                 "ErrorCode" => "InvalidModelState",
                 "Message" => "One or more properties of the request are invalid!",
                 "ModelState" => %{"Uic" => ["Uic (Uic) is invalid" <> _, _]}
               } = response.body
      end
    end
  end
end
