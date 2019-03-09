defmodule ElixirInterpreter.Core.Map do
  alias ElixirInterpreter.Core

  def to_arg([head | tail]) do
    map = head
    |> Core.Utils.remove_head_last(2, 1)
    |> Core.arg_split
    |> Core.Utils.drop_value(["", " ", ",", "=>"])
    |> Enum.map(&shaping_atom(&1))
    |> Enum.split(2)
    |> Tuple.to_list
    |> Enum.map(&Core.arg_convertion(&1))
    |> Enum.map(&List.to_tuple(&1))
    |> Map.new
    [ map | Core.arg_convertion(tail)]
  end

  def shaping_atom(str) do
    cond do
      String.last(str) == ":" ->
        ":" <> Core.Utils.remove_head_last(str, 0, 1)
      true -> str
    end
  end
end
