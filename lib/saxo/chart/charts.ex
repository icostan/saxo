defmodule Saxo.Chart.Charts do
  @moduledoc """
  Services for getting chart data for instruments.
  Allows you to set up subscriptions for streamed charts data.

  https://www.developer.saxo/openapi/referencedocs/chart/v1/charts
  """

  use Saxo.Resource
  alias Saxo.Options

  def_resource(
    :get_chart_data,
    "/chart/v1/charts",
    "Returns timestamped OHLC samples for a single instrument identified by UIC and AssetType. The time period covered by the samples and interval size between them are controlled by the combination of parameters Horizon, Time, Mode and Count.",
    AssetType: Options.asset_type(),
    Count: Options.count(),
    FieldGroups: Options.Charts.field_groups(),
    Horizon: Options.horizon(),
    Mode: Options.Charts.mode(),
    Time: Options.Charts.time(),
    Uic: Options.uic()
  )
end
