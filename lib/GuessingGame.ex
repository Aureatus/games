defmodule Games.GuessingGame do
  @moduledoc """
  Module to play a simple guessing game of a randomly generated number between 1 and 10.
  """
  def play, do: play(5)

  defp handle_attempt(attempts, answer, guess) do
    case attempts > 0 do
      true ->
        IO.puts("Incorrect!")
        if guess > answer, do: IO.puts("Too high!")
        if guess < answer, do: IO.puts("Too low!")
        play(attempts - 1)

      false ->
        IO.puts("You lose! The answer was #{answer}")
    end
  end

  def play(attempts) do
    answer = Enum.random(1..10) |> Integer.to_string()
    guess = IO.gets("Guess a number between 1 and 10:") |> String.replace("\n", "")
    win = guess == answer

    if win do
      Games.ScoreTracker.add_points(5)
      IO.puts("You win!")
    else
      handle_attempt(attempts, answer, guess)
    end
  end
end
