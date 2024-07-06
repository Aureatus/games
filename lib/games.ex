defmodule Games do
  def main(_args) do
    input =
      IO.gets("""
      What game would you like to play?
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle

      Enter "stop" to exit.
      """)
      |> String.trim()

    choice =
      cond do
        String.contains?(input, ["Guessing", "Game", "1"]) -> :guessing_game
        String.contains?(input, ["Rock", "Paper", "Scissors", "2"]) -> :rock_paper_scissors
        String.contains?(input, ["Wordle", "3"]) -> :wordle
        input == "stop" -> :stop
      end

    case choice do
      :guessing_game -> Games.GuessingGame.play()
      :rock_paper_scissors -> Games.RockPaperScissors.play()
      :wordle -> Games.Wordle.play()
      :stop -> :stop
    end

    unless choice == :stop, do: main([])
  end
end
