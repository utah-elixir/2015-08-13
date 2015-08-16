defmodule DistributedFun.Example.RickRoll do
  def register() do
    DistributedFun.register(__MODULE__, :roll, 0)
  end

  def roll() do
    System.cmd("open", ["https://www.youtube.com/watch?v=dQw4w9WgXcQ&autoplay=1"])
    true
  end

  def call() do
    DistributedFun.call(__MODULE__, :roll, [])
  end
end
