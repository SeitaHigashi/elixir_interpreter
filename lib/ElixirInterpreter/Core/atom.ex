defmodule ElixirInterpreter.Core.Atom do
  alias ElixirInterpreter.Core

  def to_arg([head | tail]) do
    [ head | tail] = case String.length(head) do
      1 ->
        [head | tail] = tail
        head = head |> Core.Utils.remove_head_last(1, 1)
        [head | tail]
      _ ->
        head = head |> Core.Utils.remove_head_last(1, 0)
        [ head | tail]
    end
    atom = head |> Core.Utils.input_convertion |> String.to_atom()
    [ atom | Core.arg_convertion(tail)]
  end
end
