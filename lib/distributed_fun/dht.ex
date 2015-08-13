defmodule DistributedFun.DHT do
  def start(port) do
    :application.load(:dht)
    :application.set_env(:dht, :port, port)
    :application.ensure_all_started(:dht)
    :ok
  end

  def ping(ip_port) do
    case String.split(to_string(ip_port), ":") do
      [ip, port] ->
        {:ok, parsed_ip} = :inet.parse_address(to_char_list(ip))
        port = String.to_integer(port)
        ping(parsed_ip, port)
    end
  end

  def ping(ip, port) do
    :dht.ping({ip, port})
  end

  def enter(id, port) when is_binary(id) do
    id
    |> :binary.decode_unsigned()
    |> enter(port)
  end
  def enter(id, port) do
    :dht.enter(id, port)
  end

  def lookup(id) when is_binary(id) do
    id
    |> :binary.decode_unsigned()
    |> lookup()
  end
  def lookup(id) do
    :dht.lookup(id)
  end
end
