defmodule Saxo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    Logger.debug("==> Starting Saxo.Application ...")

    topologies = Application.fetch_env!(:libcluster, :topologies)

    children = [
      {Cluster.Supervisor, [topologies, [name: Saxo.ClusterSupervisor]]},
      {Saxo.Server, name: {:via, :global, :saxo_api_http}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Saxo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
