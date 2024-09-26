import Config

config :libcluster,
  topologies: [
    gossip: [strategy: Elixir.Cluster.Strategy.Gossip]
  ]
