defmodule Saxo.HttpClient do
  @moduledoc "Module for making HTTP requests and handling responses."

  alias Saxo.Response

  @plug (if Mix.env() == :test do
           {Req.Test, HttpClientStub}
         else
           nil
         end)

  @spec api_url :: binary
  def api_url() do
    Application.get_env(:saxo, :api_url, "https://gateway.saxobank.com/sim/openapi")
  end

  @spec get(binary, keyword) :: {:ok, term} | {:error, term}
  def get(api_path, params) do
    req = Req.new(base_url: api_url())

    case Req.get(req,
           url: api_path,
           auth: Keyword.fetch!(params, :auth),
           params: Keyword.get(params, :query, []) |> to_query_param(),
           path_params: Keyword.get(params, :path, []),
           path_params_style: :curly,
           plug: Keyword.get(params, :plug, @plug)
         ) do
      {:ok, %{status: 200} = response} -> {:ok, %Response{status: 200, body: response.body}}
      {:ok, response} -> {:error, %Response{status: response.status, body: response.body}}
    end
  end

  defp to_query_param(query) do
    Enum.map(query, fn
      {k, [_ | _] = v} -> {k, Enum.join(v, ",")}
      {k, v} -> {k, v}
    end)
  end
end
