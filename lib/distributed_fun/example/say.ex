defmodule DistributedFun.Example.Say do
  def register() do
    DistributedFun.register(__MODULE__, :say, 1)
  end

  def say(text) do
    System.cmd("say", [text])
    true
  end

  def call(text) do
    DistributedFun.call(__MODULE__, :say, [text])
  end
end
