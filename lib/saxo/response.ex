defmodule Saxo.Response do
  @moduledoc "Wrapper for underlying HTTP response"

  @type t :: %__MODULE__{
          status: integer,
          body: map
        }
  defstruct [:status, :body]
end
