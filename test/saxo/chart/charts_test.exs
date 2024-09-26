defmodule Saxo.Chart.ChartsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch

  # TODO do we really need VCR testing

  # alias Saxo.Credentials
  # alias Saxo.Chart.Charts

  # @uic 21
  # @asset_type :FxSpot
  # @horizon 1440
  # @bearer System.fetch_env!("SAXO_BEARER")

  # setup do
  #   %{credentials: %Credentials{bearer: @bearer}}
  # end

  # describe ".get/5" do
  #   test "EURUSD spot", %{credentials: credentials} do
  #     use_cassette("get EURUSD spot") do
  #       assert {:ok, response} =
  #                Charts.get_chart_data(credentials,
  #                  AssetType: @asset_type,
  #                  Uic: @uic,
  #                  Horizon: @horizon,
  #                  Count: 1,
  #                  FieldGroups: [:ChartInfo, :Data, :DisplayAndFormat],
  #                  Mode: :From,
  #                  Time: "2024-04-08"
  #                )

  #       assert 200 = response.status

  #       assert %{
  #                "ChartInfo" => %{
  #                  "DelayedByMinutes" => 0,
  #                  "ExchangeId" => "SBFX",
  #                  "FirstSampleTime" => _,
  #                  "Horizon" => 1440
  #                },
  #                "Data" => [%{"CloseAsk" => 1.08604, "CloseBid" => 1.08584}],
  #                "DataVersion" => 1_976_175_155,
  #                "DisplayAndFormat" => %{
  #                  "Currency" => "USD",
  #                  "Decimals" => 4,
  #                  "Description" => "Euro/US Dollar",
  #                  "Format" => "AllowDecimalPips",
  #                  "Symbol" => "EURUSD"
  #                }
  #              } = response.body
  #     end
  #   end

  #   test "invalid instrument", %{credentials: credentials} do
  #     use_cassette("get invalid instrument") do
  #       assert {:error, response} =
  #                Charts.get_chart_data(credentials,
  #                  AssetType: @asset_type,
  #                  Uic: 0,
  #                  Horizon: @horizon,
  #                  Count: 1
  #                )

  #       assert 400 = response.status

  #       assert %{
  #                "ErrorCode" => "InvalidModelState",
  #                "Message" => "One or more properties of the request are invalid!",
  #                "ModelState" => %{"Uic" => ["Uic (Uic) is invalid" <> _, _]}
  #              } = response.body
  #     end
  #   end
  # end
end
