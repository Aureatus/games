defmodule Games.RockPaperScissors do
  def play do
    player_choice =
      IO.gets("Choose rock, paper, or scissors:") |> String.trim() |> String.downcase()

    ai_choice = Enum.random(["rock", "scissors", "paper"])

    win_conditions = [{"scissors", "paper"}, {"rock", "scissors"}, {"paper", "rock"}]

    if Enum.member?(win_conditions, {player_choice, ai_choice}) do
      IO.puts("You win! #{player_choice} beats #{ai_choice}.")
    else
      if player_choice == ai_choice,
        do: IO.puts("It's a tie!"),
        else: IO.puts("You lose! #{ai_choice} beats #{player_choice}.")
    end
  end
end
