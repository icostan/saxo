defmodule Saxo do
  @moduledoc "Saxo namespace"
  @type uic :: integer
  @type asset_type ::
          :Bond
          | :Cash
          | :ContractFutures
          | :Etf
          | :FuturesOption
          | :FxForwards
          | :FxSpot
          | :FxSwap
end
