defmodule Saxo.Server do
  @moduledoc "The server"

  use GenServer
  require Logger

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    Logger.debug("==> Starting Saxo.Server @ #{inspect(name)} ...")
    GenServer.start_link(__MODULE__, %{}, name: name)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({credentials, {mod, func, arg}}, _from, state) do
    response = Kernel.apply(mod, func, [credentials, arg])
    {:reply, response, state}
  end
end
