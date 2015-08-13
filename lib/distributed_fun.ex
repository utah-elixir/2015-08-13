defmodule DistributedFun do
  def start(_, _) do
    :rl.cmd(['lib/**/*.ex', 'mix compile'])
    :ets.new(__MODULE__.RPC, [:public, {:read_concurrency, true}, :named_table])
    DistributedFun.Supervisor.start_link()
  end

  def start(port \\ 1729) do
    DistributedFun.DHT.start(port)
  end

  defdelegate ping(ip_port), to: DistributedFun.DHT
  defdelegate ping(ip, port), to: DistributedFun.DHT

  def register(module, function, arity) do
    fun_id(module, function, arity)
    |> DistributedFun.DHT.enter(encode_name_in_port())
  end

  def call(module, function, args) do
    fun_id(module, function, length(args))
    |> DistributedFun.DHT.lookup()
    |> DistributedFun.RPC.call(module, function, args)
  end

  def multicall(module, function, args) do
    fun_id(module, function, length(args))
    |> DistributedFun.DHT.lookup()
    |> DistributedFun.RPC.multicall(module, function, args)
  end

  def fun_id(module, function, arity) do
    [to_string(module), 0, to_string(function), 0, to_string(arity)]
    |> hash()
  end

  defp hash(io_list) do
    :crypto.hash(:sha256, io_list)
  end

  defp encode_name_in_port do
    :erlang.node
    |> to_string()
    |> String.split("@")
    |> hd()
    |> :binary.decode_unsigned()
  end
end
