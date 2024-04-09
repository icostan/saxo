defmodule Saxo.HttpClient do
  @moduledoc "Module for making HTTP requests and handling responses."

  alias Saxo.Response

  @spec api_url :: binary
  def api_url() do
    Application.get_env(:saxo, :api_url, "https://gateway.saxobank.com/sim")
  end

  @spec get(binary, keyword) :: {:ok, term} | {:error, term}
  def get(api_path, params) do
    req = Req.new(base_url: api_url())

    case Req.get(req,
           url: api_path,
           auth: Keyword.fetch!(params, :auth),
           params: Keyword.fetch!(params, :query),
           plug: Keyword.get(params, :plug)
         ) do
      {:ok, %{status: 200} = response} -> {:ok, %Response{status: 200, body: response.body}}
      {:ok, response} -> {:error, %Response{status: response.status, body: response.body}}
    end
  end
end
