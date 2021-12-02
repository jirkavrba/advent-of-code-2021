defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  alias AdventOfCode.Input
  alias AdventOfCode.Day02.Task1

  test "task 1 example" do
    instructions = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ]

    assert Task1.calculate_destination_product(instructions) == 150
  end

  test "task 2 example" do
    instructions = Input.read_lines_from_file("priv/inputs/day02.txt")
    assert Task1.calculate_destination_product(instructions) == 1813801
  end
end
