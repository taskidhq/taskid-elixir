defmodule Taskid.MixProject do
  use Mix.Project

  def project do
    [
      app: :taskid,
      version: "0.2.0",
      description: "Takid's client library for Elixir applications",
      package: package(),
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:plug, "~> 1.11"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      name: "taskid",
      licenses: ["Apache-2.0"],
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE CHANGELOG),
      links: %{"GitHub" => "https://github.com/taskidhq/taskid-elixir"},
      source_url: "https://github.com/taskidhq/taskid-elixir"
    ]
  end
end
