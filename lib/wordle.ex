defmodule Games.Wordle do
  @moduledoc """
  This module exposes a function to play wordle - you get 6 guesses for each word.
  """

  defp update_state(state, letter, update, count) do
    if Map.get(state, :counter) |> Map.get(letter, 0) >= count do
      Map.update!(state, :response, &[:grey | &1])
    else
      Map.update!(state, :counter, fn x -> Map.update(x, letter, 1, &(&1 + 1)) end)
      |> Map.update!(:response, fn x -> [update | x] end)
    end
  end

  @type(color :: :grey, :yellow, :green)

  @spec win?([color()]) :: boolean()
  defp win?(state) do
    Enum.all?(state, fn x -> x == :green end)
  end

  @spec generate_answer :: [String.t()]
  defp generate_answer do
    Enum.random(["toast", "tarts", "hello", "beats"])
  end

  @doc """
  Given an answer and a guess, returns a list of atoms based on correctness.

    ## Examples

      iex> Games.Wordle.feedback("toast", "tasty")
      [:green, :yellow, :yellow, :yellow, :grey]

  """
  @spec feedback(String.t(), String.t()) :: [color()]
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
