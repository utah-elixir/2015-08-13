defmodule DistributedFun.Mixfile do
  use Mix.Project

  def project do
    [app: :distributed_fun,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [mod: {DistributedFun, []},
     applications: [:logger, :rl]]
  end

  defp deps do
    [{:dht, github: "camshaft/dht", ref: "130ee65a6fbd11604c7e9219d460ba22b3f4a965"},
     {:rl, github: "camshaft/rl", ref: "fba1138276f8817bc132e596acb60bf185a0a8f8"}]
  end
end
