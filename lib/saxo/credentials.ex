defmodule Saxo.Credentials do
  @moduledoc "Credentials for authorization"

  @type t :: %__MODULE__{
          bearer: binary
        }
  defstruct [:bearer]
end
