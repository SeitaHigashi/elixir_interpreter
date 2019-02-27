defmodule ElixirInterpreter do
  @moduledoc """
  Documentation for ElixirInterpreter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirInterpreter.hello
      :world

  """
  def hello do
    :world
  end

  def do_func do
    IO.gets("")
    |> ElixirInterpreter.Core.do_function
  end
end
