defmodule Games.Wordle do
  defp update_state(state, letter, update, count) do
    if Map.get(state, :counter) |> Map.get(letter, 0) >= count do
      Map.update!(state, :response, fn x -> [:grey | x] end)
    else
      Map.update!(state, :counter, fn x -> Map.update(x, letter, 1, fn y -> y + 1 end) end)
      |> Map.update!(:response, fn x -> [update | x] end)
    end
  end

  defp win?(state) do
    Enum.all?(state, fn x -> x == :green end)
  end

  defp generate_answer do
    Enum.random(["toast", "tarts", "hello", "beats"])
  end

  def feedback(answer, guess) do
    guess_list = String.split(guess, "", trim: true)
    answer_list = String.split(answer, "", trim: true)

    guess_list
    |> Enum.with_index()
    |> Enum.reduce(%{counter: %{}, response: []}, fn {letter, index}, acc ->
      count = Enum.count(answer_list, fn x -> x == letter end)

      cond do
        Enum.at(answer_list, index) == letter ->
          update_state(acc, letter, :green, count)

        Enum.find(answer_list, fn x -> x == letter end) ->
          update_state(acc, letter, :yellow, count)

        true ->
          update_state(acc, letter, :grey, count)
      end
    end)
    |> Map.get(:response)
    |> Enum.reverse()
  end

  def play, do: play(6, generate_answer())

  def play(attempt, generated_answer) do
    IO.inspect(generated_answer)

    if attempt <= 0 do
      "You lose!"
    else
      guess = IO.gets("Enter a five letter word:") |> String.trim()

      if feedback(generated_answer, guess) |> win?() do
        IO.puts("You win!")
      else
        IO.puts("Nice try!")
        play(attempt - 1, generated_answer)
      end
    end
  end
end
