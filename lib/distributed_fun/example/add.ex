defmodule DistributedFun.Example.Add do
  def register() do
    DistributedFun.register(__MODULE__, :add, 2)
  end

  def add(a, b) do
    a + b
  end

  def call(a, b) do
    DistributedFun.call(__MODULE__, :add, [a, b])
  end
end
