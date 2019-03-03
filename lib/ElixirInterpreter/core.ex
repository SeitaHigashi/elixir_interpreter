defmodule ElixirInterpreter.Core do
  alias ElixirInterpreter.Core

  def to_function(str) when is_binary(str) do
    [order | args] = str |> String.split()

    {func, module} =
      order
      |> String.split(".")
      |> List.pop_at(-1)

    module = Module.concat(module)
    func = String.to_atom(func)
    # apply(module, func, args)
    args = Enum.join(args, " ")
    %{module: module, function: func, argments: args}
  end

  def do_function(str) when is_binary(str) do
    data = to_function(str)
    args = arg_convertion(data.argments)
    apply(data.module, data.function, args)
  end

  def arg_convertion(arg) when is_binary(arg) do
    Regex.split(~r/(\%\{.*\}|\[.*\]|\{.*\}|,|\".*?[^\\]\"|\s)/, arg, include_captures: true)
    |> arg_convertion
  end

  def arg_convertion(list = [head | tail]) do
    cond do
      String.first(head) == "[" ->
        Core.List.to_arg(list)

      String.first(head) == "{" ->
        Core.Tuple.to_arg(list)

      String.first(head) == ":" ->
        Core.Atom.to_arg(list)

      Regex.match?(~r/,/, head) ->
        arg_convertion(tail)

      Regex.match?(~r/.+:\s.+/, head) ->
        tuple =
          Regex.split(~r/:\s/, (":" <> head), parts: 2)
          |> arg_convertion()
          |> List.to_tuple()

        [tuple | arg_convertion(tail)]

      Regex.match?(~r/\".*\"/, head) ->
        str =
          head
          |> Core.Utils.remove_head_last(1, 1)
          |> Core.Utils.input_convertion()

        [str | arg_convertion(tail)]

      Regex.match?(~r/\d.\d/, head) ->
        num =
          head
          |> String.to_float()

        [num | arg_convertion(tail)]

      Regex.match?(~r/\d/, head) ->
        num =
          head
          |> String.to_integer()

        [num | arg_convertion(tail)]

      Regex.match?(~r/nil/, head) ->
        [nil | arg_convertion(tail)]

      true ->
        arg_convertion(tail)
    end
  end

  def arg_convertion([]), do: []
end
