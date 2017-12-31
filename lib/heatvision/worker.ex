defmodule Heatvision.Worker do
  def start_link(track) do
    pid = spawn_link(__MODULE__, :init, [track])
    {:ok, pid}
  end

  def stop_stream(pid) do
    ExTwitter.stream_control(pid, :stop)
  end

  def init(track) do
    IO.puts "Starting Heatvision on track #{track}"
    stream = ExTwitter.stream_filter(track: track)
    state = %{}
    loop(stream, state)
  end

  def loop(stream, state) do
    tweet =  case Enum.take(stream, 1) do
      [data] -> data
      _ -> nil
    end
    new_state = cond do
      tweet && tweet.place ->
        key = {tweet.place.country_code, tweet.place.name}
        IO.inspect key
        Map.update(state, key, 1, fn(a) -> a + 1 end)
      true ->
        state
    end
    IO.inspect new_state
    loop(stream, new_state)
  end
end