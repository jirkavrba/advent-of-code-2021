defmodule AdventOfCode.Day09Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day09

  test "task 1 example" do
    input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """
    |> String.split("\n", trim: true)

    assert Day09.find_sum_of_low_points(input) == 15
  end

  test "task 1 input" do
    # input = Input.read_lines_from_file("priv/inputs/day09.txt")
    # assert Day09.find_sum_of_low_points(input) == 0
  end

  test "task 2 example" do
    # input = """
    # """
    # |> String.split("\n", trim: true)

    # assert Day09.__task2__(input) == 0
  end

  test "task 2 input" do
    # input = Input.read_lines_from_file("priv/inputs/day09.txt")
    # assert Day09.__task2__(input) == 0
  end
end
