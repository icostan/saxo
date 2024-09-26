defmodule Saxo.MixProject do
  use Mix.Project

  def project do
    [
      app: :saxo,
      version: "0.2.0",
      elixir: "~> 1.16",
      name: "Saxo",
      description: "Saxo API Client for Elixir (https://www.developer.saxo/openapi/learn)",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      releases: [
        saxo_api: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ]
    ]
  end

  def package() do
    %{
      licenses: ["MIT"],
      maintainers: ["Iulian Costan"],
      links: %{"GitHub" => "https://github.com/icostan/saxo"}
    }
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Saxo.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.4"},
      {:nimble_options, "~> 1.1.1"},
      {:libcluster, "~> 3.3"},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:exvcr, "~> 0.11", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:plug, "~> 1.0", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      check: [
        "compile --warnings-as-errors --force",
        "format --check-formatted",
        "dialyzer",
        "credo"
      ]
    ]
  end
end
