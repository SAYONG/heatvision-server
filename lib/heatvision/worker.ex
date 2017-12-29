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
    for tweet <- stream do
      if tweet.place do
        IO.puts tweet.text
      else
        nil
      end
    end
  end
end