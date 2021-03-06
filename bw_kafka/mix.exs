defmodule BwKafka.MixProject do
  use Mix.Project

  def project do
    [
      app: :bw_kafka,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      #releases: [
      #  pre: [
          #include_executables_for: [:unix],
          #applications: [runtime_tools: :permanent]
      #  ],
      #],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BwKafka.Application, []},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      #{:broadway_kafka, "~> 0.3"},
      {:broadway_kafka, github: "fcojavierlahoz/broadway_kafka"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:myxql, "~> 0.5.0"},
    ]
  end
end
