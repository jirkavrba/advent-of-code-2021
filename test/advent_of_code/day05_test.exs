defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day05.{Task1, Task2}

  test "task 1 example" do
    input = [
    ]

    assert Task1.___(input) == 0
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day05.txt")
    assert Task1.___(input) == 0
  end

  test "task 2 example" do
    input = [
    ]

    assert Task2.___(input) == 0
  end

  test "task 2 input" do
    input = Input.read_lines_from_file("priv/inputs/day05.txt")
    assert Task2.___(input) == 0
  end
end
