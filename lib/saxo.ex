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

  @asset_types [
    :Bond,
    :Cash,
    :ContractFutures,
    :Etf,
    :FuturesOption,
    :FxForwards,
    :FxSpot,
    :FxSwap
  ]
  def asset_types(), do: @asset_types
end
