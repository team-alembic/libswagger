defmodule Swagger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :libswagger,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :yaml_elixir]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:maxwell, "~> 2.2"},
      {:hackney, "~> 1.11", optional: true},
      {:yamerl, "~> 0.7"},
      {:yaml_elixir, "~> 1.3"},
      {:ex_json_schema, "~> 0.5"}
    ]
  end
end
