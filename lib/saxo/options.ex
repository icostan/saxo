defmodule Saxo.Options do
  @moduledoc "Common options for Saxo API"

  @asset_type [
    type: {:in, Saxo.asset_types()},
    required: true,
    doc: "The type of the instrument to get, one of the following #{inspect(Saxo.asset_types())}"
  ]
  def asset_type(), do: @asset_type

  @asset_types [
    type: :string,
    doc:
      "Comma separated list of one or more asset types to search for. E.g. AssetTypes=FxSpot,Stock"
  ]
  def asset_types(), do: @asset_types

  @uic [
    type: :integer,
    required: true,
    doc: "The Universal Instrument Code (UIC) of the instrument to get"
  ]
  def uic(), do: @uic

  @account_key [
    type: :string,
    doc:
      "If specified, access permissions to instruments for the specified account will be evaluated"
  ]
  def account_key(), do: @account_key

  @client_key [type: :string]
  def client_key(), do: @client_key

  @field_groups [
    type: {:in, [:SupportedOrderTypeSettings, :OrderSetting, :TradingSessions, :MarketData]},
    doc:
      " Comma separated list of the following options: :SupportedOrderTypeSettings, :OrderSetting, :TradingSessions, :MarketData "
  ]
  def field_groups(), do: @field_groups

  @option_space_segment [
    type: {:in, [:AllDates, :DefaultDates, :SpecificDates, :None, :UnderlyingUic]},
    doc: "Specify how large a segment of the complete option space to return"
  ]
  def option_space_segment(), do: @option_space_segment

  @trading_status [
    type: {:in, [:NonTradable, :NotDefined, :ReduceOnly, :Tradable]},
    doc: "Trading status of an instrument"
  ]
  def trading_status(), do: @trading_status

  @tags [type: :string]
  def tags(), do: @tags

  @uics [
    type: :string,
    doc: "Limit list to return information for the following comma separated Uics"
  ]
  def uics(), do: @uics

  @skip [type: :integer]
  def skip(), do: @skip

  @top [type: :integer]
  def top(), do: @top
end
