defmodule Saxo.Options do
  @moduledoc "Common options for Saxo API"

  def asset_type(),
    do: [
      type: {:in, Saxo.asset_types()},
      required: true,
      doc:
        "The type of the instrument to get, one of the following #{inspect(Saxo.asset_types())}"
    ]

  def asset_types(),
    do: [
      type: :string,
      doc:
        "Comma separated list of one or more asset types to search for. E.g. AssetTypes=FxSpot,Stock"
    ]

  def uic(),
    do: [
      type: :integer,
      required: true,
      doc: "The Universal Instrument Code (UIC) of the instrument to get"
    ]

  def account_key(),
    do: [
      type: :string,
      doc:
        "If specified, access permissions to instruments for the specified account will be evaluated"
    ]

  def client_key(), do: [type: :string]

  def option_space_segment(),
    do: [
      type: {:in, [:AllDates, :DefaultDates, :SpecificDates, :None, :UnderlyingUic]},
      doc: "Specify how large a segment of the complete option space to return"
    ]

  def trading_status(),
    do: [
      type: {:in, [:NonTradable, :NotDefined, :ReduceOnly, :Tradable]},
      doc: "Trading status of an instrument"
    ]

  def tags(), do: [type: :string]

  def uics(),
    do: [
      type: :string,
      doc: "Limit list to return information for the following comma separated Uics"
    ]

  def skip(), do: [type: :integer]

  def top(), do: [type: :integer]

  def count(),
    do: [
      type: :integer,
      doc:
        "Specifies maximum number of samples to return. Maximum is 1200. If not specified a default of 1200 samples are returned."
    ]

  def horizon(),
    do: [
      type: {:in, [1, 5, 10, 15, 30, 60, 120, 240, 360, 480, 1440, 10_080, 43_200]},
      required: true,
      doc:
        "The time period that each sample covers. Values are interpreted in minutes: 1, 5, 10, 15, 30, 60, 120, 240, 360, 480, 1440, 10080, 43200."
    ]

  defmodule Charts do
    @moduledoc false

    def field_groups(),
      do: [
        type: {:list, {:in, [:BlockInfo, :ChartInfo, :Data, :DisplayAndFormat]}},
        doc:
          "Use FieldGroups (BlockInfo, ChartInfo, Data, DisplayAndFormat) to add additional information to the samples like display/formatting details or information about the price source. If FieldGroups are not specified in the request then the response defaults to only hold the bare OHLC samples and nothing else."
      ]

    def mode(),
      do: [
        type: {:in, [:From, :UpTo]},
        doc:
          "If Time is supplied, mode specifies if the endpoint should returns samples 'UpTo' (and including) or 'From' (and including) the specified time."
      ]

    def time(),
      do: [
        type: :string,
        doc:
          "Specifies the time of a sample, which must either be the first (If Mode==From) or the last (if Mode==UpTo) in the returned data."
      ]
  end

  defmodule Instruments do
    @moduledoc false

    def field_groups(),
      do: [
        type: {:list, :string},
        doc:
          "Comma separated list of the following options: SupportedOrderTypeSettings, OrderSetting, TradingSessions, MarketData"
      ]
  end
end
