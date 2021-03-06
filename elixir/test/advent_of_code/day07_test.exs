defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day07

  test "task 1 example" do
    input = "16,1,2,0,4,2,7,1,2,14"
    assert Day07.compute_fuel_consumption(input, :constant) == 37
  end

  test "task 1 input" do
    input =
      "priv/inputs/day07.txt"
      |> Input.read_lines_from_file()
      |> Enum.at(0)

    assert Day07.compute_fuel_consumption(input, :constant) == 352997
  end

  test "task 2 example" do
    input = "16,1,2,0,4,2,7,1,2,14"
    assert Day07.compute_fuel_consumption(input, :linear) == 168
  end

  test "task 2 input" do
    input =
      "priv/inputs/day07.txt"
      |> Input.read_lines_from_file()
      |> Enum.at(0)

    assert Day07.compute_fuel_consumption(input, :linear) == 101571302
  end
end
