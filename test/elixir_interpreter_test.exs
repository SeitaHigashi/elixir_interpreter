defmodule ElixirInterpreterTest do
  use ExUnit.Case
  doctest ElixirInterpreter

  test "greets the world" do
    assert ElixirInterpreter.hello() == :world
  end

  test "arg_convertion string" do
    assert ElixirInterpreter.Core.arg_convertion("\"string\"") == ["string"]
    assert ElixirInterpreter.Core.arg_convertion("\"\"") == [""]
  end

  test "arg_convertion integer" do
    assert ElixirInterpreter.Core.arg_convertion("2") == [2]
    assert ElixirInterpreter.Core.arg_convertion("2, 3") == [2, 3]
  end

  test "arg_convertion list" do
    assert ElixirInterpreter.Core.arg_convertion("\[2, 3\]") == [[2,3]]
    assert ElixirInterpreter.Core.arg_convertion("\[2,\[3\]\]") == [[2,[3]]]
    assert ElixirInterpreter.Core.arg_convertion("\[2\]") == [[2]]
    assert ElixirInterpreter.Core.arg_convertion("2,3") == [2,3]
    assert ElixirInterpreter.Core.arg_convertion("2") == [2]
    assert ElixirInterpreter.Core.arg_convertion("1,[2,[3,[4,5,[[2]]]]]") == [1,[2,[3,[4,5,[[2]]]]]]
    assert ElixirInterpreter.Core.arg_convertion("[\"string\", 2, [3]]") == [["string", 2, [3]]]
  end

end
