defmodule ElixirInterpreterTest do
  use ExUnit.Case
  doctest ElixirInterpreter

  test "greets the world" do
    assert ElixirInterpreter.hello() == :world
  end

  test "arg_convertion string" do
    assert ElixirInterpreter.Core.arg_convertion("\"string\"") == ["string"]
    assert ElixirInterpreter.Core.arg_convertion("\"\\\"string\\\"\"") == ["\"string\""]
    assert ElixirInterpreter.Core.arg_convertion("\"\"") == [""]
  end

  test "arg_convertion integer" do
    assert ElixirInterpreter.Core.arg_convertion("2") == [2]
    assert ElixirInterpreter.Core.arg_convertion("2, 3") == [2, 3]
  end

  test "arg_convertion float" do
    assert ElixirInterpreter.Core.arg_convertion("2.1") == [2.1]
    assert ElixirInterpreter.Core.arg_convertion("2.1, 3.1") == [2.1, 3.1]
  end

  test "arg_convertion atom" do
    assert ElixirInterpreter.Core.arg_convertion(":atom") == [:atom]
    assert ElixirInterpreter.Core.arg_convertion(":\"atom\"") == [:atom]
    assert ElixirInterpreter.Core.arg_convertion(":\"\\\"atom\\\"\"") == [:"\"atom\""]
  end

  test "arg_convertion map" do
    assert ElixirInterpreter.Core.arg_convertion("\%\{\"2\" => 2, \"3\" => 3\}") == [%{"2"=>2, "3"=>3}]
    assert ElixirInterpreter.Core.arg_convertion("\%\{\"3\" => 3\, map: 2}") == [%{"3" => 3, map: 2}]
    assert ElixirInterpreter.Core.arg_convertion("\%\{\"3\" => 3\, map: [2, 3]}") == [%{"3" => 3, map: [2, 3]}]
  end

  test "arg_convertion tuple" do
    assert ElixirInterpreter.Core.arg_convertion("\{2, 3\}") == [{2,3}]
    assert ElixirInterpreter.Core.arg_convertion("\{2, \"3\"\}") == [{2,"3"}]
  end

  test "arg_convertion list" do
    assert ElixirInterpreter.Core.arg_convertion("\[2, 3\]") == [[2,3]]
    assert ElixirInterpreter.Core.arg_convertion("\[2,\[3\]\]") == [[2,[3]]]
    assert ElixirInterpreter.Core.arg_convertion("\[2\]") == [[2]]
    assert ElixirInterpreter.Core.arg_convertion("2,3") == [2,3]
    assert ElixirInterpreter.Core.arg_convertion("2") == [2]
    assert ElixirInterpreter.Core.arg_convertion("1,[2,[3,[4,5,[[2]]]]]") == [1,[2,[3,[4,5,[[2]]]]]]
  end

  test "arg_convertion keyword list" do
    assert ElixirInterpreter.Core.arg_convertion("\[num: 3, str: \"string\"\]") == [[num: 3, str: "string"]]
    assert ElixirInterpreter.Core.arg_convertion("\[num: 3, keyword: \[str: \"string\"\]\]") == [[num: 3, keyword: [str: "string"]]]
    assert ElixirInterpreter.Core.arg_convertion("\[num: 3, keyword: \[str: \"string\", exam: :atom\]\]") == [[num: 3, keyword: [str: "string", exam: :atom]]]
  end

  test "arg_convertion" do
    assert ElixirInterpreter.Core.arg_convertion("[\"string\", 2, [3]]") == [["string", 2, [3]]]
    assert ElixirInterpreter.Core.arg_convertion("\{2, \[3.1\]\}") == [{2,[3.1]}]
    assert ElixirInterpreter.Core.arg_convertion("\[2, \{3\}\]") == [[2,{3}]]
    assert ElixirInterpreter.Core.arg_convertion("\[2.1, \{3\}\]") == [[2.1,{3}]]
  end

end
