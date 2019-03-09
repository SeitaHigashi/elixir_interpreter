defmodule ElixirInterpreter.Core.Struct do
  alias ElixirInterpreter.Core

  def to_arg([head | tail]) do
    name =
      head
      |> String.split("{", parts: 2)
      |> List.first()
      |> Core.Utils.remove_head_last(1, 0)

    len = name |> String.length()
    head = "%{" <> Core.Utils.remove_head_last(head, len + 2, 0)

    map =
      [head]
      |> Core.Map.to_arg()
      |> List.first()

    module =
      name
      |> String.split(".")
      |> Module.concat()

    st = struct(module, map)
    [st | Core.arg_convertion(tail)]
  end
end
