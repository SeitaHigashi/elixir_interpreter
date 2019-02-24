defmodule ElixirInterpreter.Core do
  def to_function(str) when is_binary(str) do
    [ order | args ] = str |> String.split
    { func, module } = order
    |> String.split(".")
    |> List.pop_at(-1)
    module = Module.concat(module)
    func = String.to_atom(func)
    apply(module, func, args)
  end

  def arg_convertion( arg, inheriting \\ [])
  def arg_convertion([arg | tail], inheriting ) do
    IO.puts "\n" <> arg
    IO.inspect tail
    IO.inspect inheriting
    cond do
      String.match? arg, ~r/\[/ ->
        IO.puts "["
        tail = [Regex.replace(~r/\[/, arg, "") | tail ]
        head = tail
        |> arg_convertion
        [head | inheriting]
        |> Enum.reverse
      String.match? arg, ~r/\]/ ->
        IO.puts "]"
        [Regex.replace(~r/\]/, arg, "") | [] ]
        |> arg_convertion
      String.match? arg, ~r/,/ ->
        IO.puts ","
        [Regex.replace(~r/,/, arg, "") | tail]
        |> arg_convertion(inheriting)
      String.match? arg, ~r/\d+/ ->
        IO.puts "number"
        arg = String.to_integer(arg)
        [arg | arg_convertion(tail, inheriting)]
      tail == [] ->
        IO.puts "[]"
        [arg | []]
      true ->
        IO.puts "true"
        [ arg | arg_convertion(tail, inheriting)]
    end
  end
  def arg_convertion([], _inheriting ), do: []
end
