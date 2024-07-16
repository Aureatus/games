defmodule Games.Application do
  use Application

  @impl true
  def start(_start_type, _start_args) do
    children = [
      {Games.ScoreTracker, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Games.Supervisor)
  end
end
