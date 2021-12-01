defmodule AdventOfCode.Input do
  @moduledoc """
  Module containing small helper functions to allow sharing logic between tests
  """

  @spec read_lines_from_file(String.t()) :: list(String.t())
  def read_lines_from_file(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec read_ints_from_file(String.t()) :: list(integer())
  def read_ints_from_file(filename) do
    filename
    |> read_lines_from_file()
    |> Enum.map(&String.to_integer/1)
  end

end
