defmodule ElixirInterpreter.Core.List do
  alias ElixirInterpreter.Core

  def to_arg([head | tail]) do
    list =
      cond do
        Regex.match?(~r/\[(.+:\s.+)+\]/, head) ->
          head
          |> Core.Utils.remove_head_last(1, 1)
          |> String.split(", ")
          |> Core.arg_convertion()

        true ->
          head
          |> Core.Utils.remove_head_last(1, 1)
          |> Core.arg_convertion()
      end

    [list | Core.arg_convertion(tail)]
  end
end
