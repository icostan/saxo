defmodule Saxo do
  @moduledoc "Saxo namespace"
  @type credentials :: Saxo.Credentials.t()
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
          | :Stock
          | :StockOption
          | :StockIndex
          | :StockIndexOption

  @asset_types [
    :Bond,
    :Cash,
    :ContractFutures,
    :Etf,
    :FuturesOption,
    :FxForwards,
    :FxSpot,
    :FxSwap,
    :Stock,
    :StockOption,
    :StockIndex,
    :StockIndexOption
  ]
  def asset_types(), do: @asset_types
end
