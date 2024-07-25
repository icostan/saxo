defmodule Saxo.Chart.Charts do
  @moduledoc "https://www.developer.saxo/openapi/referencedocs/chart/v1/charts"

  alias Saxo.{Credentials, HttpClient, Response}

  @type horizon :: 1 | 5 | 10 | 15 | 30 | 60 | 120 | 240 | 360 | 480 | 1440 | 10_080 | 43_200
  @type mode :: :From | :UpTo
  @type field_group :: :ChartInfo | :Data | :DisplayAndFormat
  @type option ::
          {:count, pos_integer}
          | {:field_groups, list(field_group)}
          | {:mode, mode}
          | {:time, String.t()}
  @type options :: [option]

  @path "/chart/v1/charts"

  @spec get(Credentials.t(), Saxo.asset_type(), Saxo.uic(), horizon, options) ::
          {:ok, Response.t()} | {:error, Response.t()}
  def get(credentials, asset_type, uic, horizon, options \\ []) do
    field_groups =
      Keyword.get(options, :field_groups, [:Data])
      |> Enum.map_join(",", &Atom.to_string(&1))

    HttpClient.get(@path,
      auth: {:bearer, credentials.bearer},
      query: [
        AssetType: asset_type,
        Uic: uic,
        Horizon: horizon,
        Count: Keyword.get(options, :count, 100),
        FieldGroups: field_groups,
        Mode: Keyword.get(options, :mode),
        Time: Keyword.get(options, :time)
      ],
      plug: nil
    )
  end
end
