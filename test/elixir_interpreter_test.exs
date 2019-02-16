defmodule ElixirInterpreterTest do
  use ExUnit.Case
  doctest ElixirInterpreter

  test "greets the world" do
    assert ElixirInterpreter.hello() == :world
  end
end
