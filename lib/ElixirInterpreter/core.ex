defmodule ElixirInterpreter.Core do
  def to_function(str) when is_binary(str) do
    [ order | arg ] = str |> String.split
    { func, module } = order
    |> String.split(".")
    |> List.popat(-1)
    module = Module.concat(module)
    func = Function.capture(module, String.to_atom(func), 1)
  end
end
