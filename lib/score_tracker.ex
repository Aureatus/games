defmodule Games.ScoreTracker do
  use GenServer

  @impl true
  def init(_init_arg) do
    {:ok, 0}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:add, points}, state) do
    {:noreply, state + points}
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def current_score do
    GenServer.call(MyScoreTracker, :get)
  end

  def add_points(points) do
    GenServer.cast(MyScoreTracker, {:add, points})
  end
end
