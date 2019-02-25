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

  #Regex.split ~r{(\[.*\]|,)}, string, include_captures: true
  def arg_convertion(arg) when is_binary(arg) do
    Regex.split(~r/(\{.*\}|\[.*\]|,|\s)/, arg, include_captures: true)
    |> arg_convertion
  end
  def arg_convertion([head | tail]) do
    #IO.puts "\nhead:" <> head
    #IO.inspect tail
    cond do
      Regex.match?(~r/\[.*\]/, head) ->
        #IO.puts "match:[]"
        list = head
        |> remove_head_last(1,1)
        |> arg_convertion
        [ list | arg_convertion(tail)]
      Regex.match?(~r/,/, head) -> arg_convertion(tail)
      Regex.match?(~r/\d/, head) ->
        #IO.puts "match:number"
        num = head
        |> String.to_integer()
        [num | arg_convertion(tail)]
      true ->
        #IO.puts "match:true"
        arg_convertion(tail)
    end
  end
  def arg_convertion([]), do: []

  defp remove_head_last(str, head, last) do
    len = String.length(str)
    str
    |> String.slice(head, len)
    |> String.reverse
    |> String.slice(last, len)
    |> String.reverse
  end

end
