defmodule AdventOfCode.Day06Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day06

  test "task 1 example" do
    input = "3,4,3,1,2"

    assert Day06.compute_number_of_lanternfish_after(input) == 5934
  end

  test "task 1 input" do
    input = "priv/inputs/day06.txt"
    |> Input.read_lines_from_file()
    |> Enum.at(0)

    assert Day06.compute_number_of_lanternfish_after(input) == 379114
  end

  test "task 2 example" do
    input = "3,4,3,1,2"
    assert Day06.compute_number_of_lanternfish_after(input, 256) == 26984457539
  end

  test "task 2 input" do
    input = "priv/inputs/day06.txt"
    |> Input.read_lines_from_file()
    |> Enum.at(0)

    assert Day06.compute_number_of_lanternfish_after(input, 256) == 1702631502303
  end
end
