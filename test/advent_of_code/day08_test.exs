defmodule AdventOfCode.Day08Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day08

  test "task 1 example" do
    input = """
    """ 
    |> String.split("\n", trim: true)

    assert Day08.__task1__(input) == 0
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day08.txt")
    assert Day08.__task1__(input) == 0
  end

  test "task 2 example" do
    input = """
    """
    |> String.split("\n", trim: true)

    assert Day08.__task2__(input) == 0
  end

  test "task 2 input" do
    input = Input.read_lines_from_file("priv/inputs/day08.txt")
    assert Day08.__task2__(input) == 0
  end
end