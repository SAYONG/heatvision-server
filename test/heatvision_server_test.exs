defmodule HeatvisionServerTest do
  use ExUnit.Case
  doctest HeatvisionServer

  test "greets the world" do
    assert HeatvisionServer.hello() == :world
  end
end
