defmodule Games.WordleTest do
  use ExUnit.Case

  doctest Games.Wordle

  test "feedback" do
    assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
    assert Games.Wordle.feedback("aaaaa", "aaaab") == [:green, :green, :green, :green, :grey]

    assert Games.Wordle.feedback("abdce", "edcba") == [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]

    assert Games.Wordle.feedback("aaabb", "xaaaa") == [:grey, :green, :green, :yellow, :grey]
    assert Games.Wordle.feedback("aaaaa", "xxxxx") == [:grey, :grey, :grey, :grey, :grey]
  end
end
