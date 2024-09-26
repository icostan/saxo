defmodule Saxo.ReferenceData.Instruments do
  @moduledoc """
  End points serving instrument resources.

  https://www.developer.saxo/openapi/referencedocs/ref/v1/instruments
  """

  use Saxo.Resource
  alias Saxo.Options

  def_resource(
    :search,
    "/ref/v1/instruments",
    "Search for instruments or contract option roots",
    "$skip": Options.skip(),
    "$top": Options.top(),
    AccountKey: Options.account_key(),
    AssetTypes: Options.asset_types(),
    CanParticipateInMultiLegOrder: [type: :boolean],
    Class: [type: {:in, [:Complex, :NonComplex]}],
    ExchangeId: [type: :string, doc: "ID of the exchange that the instruments must match."],
    IncludeNonTradable: [type: :boolean],
    Keywords: [
      type: :string,
      doc: "Search for matching keywords in the instruments. Separate keywords with spaces."
    ],
    Tags: Options.tags(),
    Uics: Options.uics()
  )

  def_resource(
    :options_space,
    "/ref/v1/instruments/contractoptionspaces/{OptionRootId}",
    "Get option details and options space for specified option root.",
    OptionRootId: [type: :integer, required: true, doc: "ID of the contract option root."],
    CanParticipateInMultiLegOrder: [type: :boolean],
    ClientKey: Options.client_key(),
    ExpiryDates: [
      type: :string,
      doc: "Return specific information for the ExpiryDates in this array"
    ],
    OptionSpaceSegment: Options.option_space_segment(),
    TradingStatus: Options.trading_status(),
    UnderlyingUic: [type: :integer, doc: "The uic of the underlying instrument."]
  )

  def_resource(
    :instruments,
    "/ref/v1/instruments/details",
    "Use this operation to retrieve detailed information a list of instruments.",
    AccountKey: Options.account_key(),
    AssetTypes: Options.asset_types(),
    FieldGroups: Options.Instruments.field_groups(),
    Tags: Options.tags(),
    Uics: Options.uics()
  )

  def_resource(
    :instrument,
    "/ref/v1/instruments/details/{Uic}/{AssetType}",
    "Use this operation to retrieve details for a specific instrument.",
    "$skip": Options.skip(),
    "$top": Options.top(),
    AssetType: Options.asset_type(),
    Uic: Options.uic(),
    FieldGroups: Options.Instruments.field_groups(),
    AccountKey: Options.account_key(),
    ClientKey: Options.client_key()
  )

  def_resource(
    :futures_space,
    "/ref/v1/instruments/futuresspaces/{ContinuousFuturesUic}",
    "Provides an overview of a contract futures space.",
    ContinuousFuturesUic: [
      type: :integer,
      required: true,
      doc: "The UIC of the continuous futures instrument of the space."
    ]
  )

  def_resource(
    :trading_schedules,
    "/ref/v1/instruments/tradingschedule/{Uic}/{AssetType}",
    "Returns trading schedule for a given uic and asset type.",
    AssetType: Options.asset_type(),
    Uic: Options.uic()
  )
end
