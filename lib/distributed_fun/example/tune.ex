defmodule DistributedFun.Example.Tune do
  def register() do
    DistributedFun.register(__MODULE__, :play, 1)
  end

  def play({note, length}) do
    play({note, length, "sin"})
  end
  def play({_note, length, _type}) when length > 3 or length <= 0 do
    throw :note_out_of_range
  end
  def play({note, length, type}) do
    note = note |> to_string |> String.upcase
    args = ["-qn", "synth", to_string(length), to_string(type), note]
    System.cmd("play", args)
    "#{note} -> #{length}"
  end

  def mary_had_a_little_lamb(speed \\ 1.0) do
    [e: 0.5,
     d: 0.5,
     c: 0.5,
     d: 0.5,
     e: 0.5,
     e: 0.5,
     e: 1.0,
     d: 0.5,
     d: 0.5,
     d: 1.0,
     e: 0.5,
     g: 0.5,
     g: 1.0,
     e: 0.5,
     d: 0.5,
     c: 0.5,
     d: 0.5,
     e: 0.5,
     e: 0.5,
     e: 0.5,
     e: 0.5,
     d: 0.5,
     d: 0.5,
     e: 0.5,
     d: 0.5,
     c: 1.5,]
    |> Enum.map(&(put_elem(&1, 1, elem(&1, 1) * speed)))
    |> call()
  end

  def call(notes) do
    notes
    |> Enum.map(&(DistributedFun.call(__MODULE__, :play, [&1])))
  end
end
