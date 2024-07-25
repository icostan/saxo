defmodule Saxo.Resource do
  @moduledoc "Provides macro"

  alias Saxo.{HttpClient, Credentials}

  defmacro __using__(_opts) do
    quote location: :keep do
      import Saxo.Resource
    end
  end

  @doc "Macro for creating Saxo resources"
  defmacro def_resource(name, endpoint, doc, schema) do
    quote location: :keep do
      @doc "#{unquote(doc)}\n\nOptions:\n#{NimbleOptions.docs(unquote(schema))}"
      @spec unquote(name)(Credentials.t(), keyword) :: map
      def unquote(name)(credentials, params) do
        schema = NimbleOptions.new!(unquote(schema))
        params = NimbleOptions.validate!(params, schema)

        {path_params, query_params} =
          Keyword.split_with(params, fn {k, v} ->
            String.contains?(unquote(endpoint), "{#{k}}")
          end)

        HttpClient.get(unquote(endpoint),
          auth: {:bearer, credentials.bearer},
          path: path_params,
          query: query_params
        )
      end
    end
  end
end
