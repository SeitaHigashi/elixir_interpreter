defmodule ElixirInterpreter.Core.Utils do
  def remove_head_last(str, head, last) do
    len = String.length(str)

    str
    |> String.slice(head, len)
    |> String.reverse()
    |> String.slice(last, len)
    |> String.reverse()
  end

  def input_convertion(str) when is_binary(str), do: str |> String.replace("\\", "")

  def drop_value(list, [head | tail]) when is_list(list) do
    list
    |> Enum.reject(fn x -> x == head end)
    |> drop_value(tail)
  end
  def drop_value(list, []) when is_list(list), do: list
end
