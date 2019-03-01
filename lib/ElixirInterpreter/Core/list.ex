defmodule ElixirInterpreter.Core.List do
  alias ElixirInterpreter.Core
  def to_arg([head | tail]) do
    list = head
    |> Core.Utils.remove_head_last(1,1)
    |> Core.arg_convertion
    [ list | Core.arg_convertion(tail)]
  end
end
