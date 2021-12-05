defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day05

  test "task 1 example" do
    input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
    |> String.split("\n", trim: true)

    assert Day05.compute_venture_overlaps(input) == 5
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day05.txt")
    assert Day05.compute_venture_overlaps(input) == 6005
  end

  test "task 2 example" do
    input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
    |> String.split("\n", trim: true)

    assert Day05.compute_venture_overlaps(input, true) == 12
  end

  test "task 2 input" do
    input = Input.read_lines_from_file("priv/inputs/day05.txt")
    assert Day05.compute_venture_overlaps(input, true) == 23864
  end
end
