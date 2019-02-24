defmodule ElixirInterpreterTest do
  use ExUnit.Case
  doctest ElixirInterpreter

  test "greets the world" do
    assert ElixirInterpreter.hello() == :world
  end

  test "arg_convertion" do
    assert ElixirInterpreter.Core.arg_convertion(["\[2,", "3\]"]) == [[2,3]]
  end
end
