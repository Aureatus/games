defmodule Games.GuessingGame do
  def play, do: play(5)

  def play(attempts) do
    answer = Enum.random(1..10) |> Integer.to_string()
    guess = IO.gets("Guess a number between 1 and 10:") |> String.replace("\n", "")
    win = guess == answer

    if win do
      IO.puts("You win!")
    else
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
  end
end
