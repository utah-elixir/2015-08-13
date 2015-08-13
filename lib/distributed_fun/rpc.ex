defmodule DistributedFun.RPC do
  def call([], module, function, args) do
    raise UndefinedFunctionError, module: module, function: function, arity: length(args)
  end
  def call(nodes, module, function, args) do
    nodes
    |> Enum.at(:random.uniform(length(nodes)) - 1)
    |> connect()
    |> :rpc.call(module, function, args)
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

  defp connect({ip, user}) do
    node = format_node(ip, user)
    Node.ping(node) && node
  end

  defp format_node({a, b, c, d}, user) do
    :"#{:binary.encode_unsigned(user)}@#{a}.#{b}.#{c}.#{d}"
  end
end
