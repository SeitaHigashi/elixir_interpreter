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

  defp argment_convertion([arg | tail]) do
  end
end
