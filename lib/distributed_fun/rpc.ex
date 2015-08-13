defmodule DistributedFun.RPC do
  def call([], module, function, args) do
    raise UndefinedFunctionError, module: module, function: function, arity: length(args)
  end
  def call(nodes, module, function, args) do
    :random.seed(:erlang.now())
    nodes
    |> Enum.shuffle()
    |> try_call(module, function, args)
  end

  defp try_call([], _, _, _) do
    {:error, :nodes_down}
  end
  defp try_call([node | rest], module, function, args) do
    case :rpc.call(connect(node), module, function, args) do
      {:badrpc, _} ->
        try_call(rest, module, function, args)
      res ->
        res
    end
  end

  def multicall(nodes, module, function, args) do
    nodes
    |> Enum.reduce([], &connect/2)
    |> :rpc.multicall(module, function, args)
  end

  defp connect(node, acc) do
    if connect(node) do
      [node | acc]
    else
      acc
    end
  end

  defp connect({ip, user} = key) do
    node = format_node(ip, user)
    case :ets.lookup(__MODULE__, key) do
      [] ->
        Node.ping(node) && :ets.insert(__MODULE__, {key, true}) && node
      _v ->
        node
    end
  end

  defp format_node({a, b, c, d}, user) do
    :"#{:binary.encode_unsigned(user)}@#{a}.#{b}.#{c}.#{d}"
  end
end
