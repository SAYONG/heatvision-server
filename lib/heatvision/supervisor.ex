defmodule Heatvision.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: :heatvision_supervisor)
  end

  def start_child(track) do
    Supervisor.start_child(:heatvision_supervisor, [track])
  end

  def init(_) do
    supervise(
      [worker(Heatvision.Worker, [])],
      strategy: :simple_one_for_one
    )
  end
end
