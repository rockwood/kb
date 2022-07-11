defmodule Kb.Mixfile do
  use Mix.Project

  def project do
    [
      app: :kb,
      version: "0.1.0",
      elixir: "~> 1.4-rc",
      escript: escript_config(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:floki, "~> 0.17"},
      {:csv, "~> 2.0"}
    ]
  end

  defp escript_config do
    [main_module: Kb.CLI]
  end
end
