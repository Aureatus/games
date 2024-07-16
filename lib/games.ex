defmodule Games do
  def main(_args) do
    input =
      IO.gets("""
      What game would you like to play?
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle

      Enter "stop" to exit.
      Enter "score" to view your current score
      """)
      |> String.trim()

    choice =
      cond do
        String.contains?(input, ["Guessing", "Game", "1"]) -> :guessing_game
        String.contains?(input, ["Rock", "Paper", "Scissors", "2"]) -> :rock_paper_scissors
        String.contains?(input, ["Wordle", "3"]) -> :wordle
        input == "stop" -> :stop
        input == "score" -> :score
      end

    case choice do
      :guessing_game -> Games.GuessingGame.play()
      :rock_paper_scissors -> Games.RockPaperScissors.play()
      :wordle -> Games.Wordle.play()
      :score -> Games.ScoreTracker.current_score() |> IO.puts()
      :stop -> :stop
    end

    unless choice == :stop, do: main([])
  end
end
