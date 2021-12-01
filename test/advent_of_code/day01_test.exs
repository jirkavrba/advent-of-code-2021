defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  alias AdventOfCode.Day01.{Task1, Task2}

  test "task 1 example" do
    report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Task1.compute_depth_increments(report) == 7
  end

  test "task 1 input" do
    report = File.read!("priv/inputs/day01.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)

    assert Task1.compute_depth_increments(report) == 1451
  end

  test "task 2 example" do
    report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Task2.compute_depth_increments(report) == 5
  end

  test "task 2 input" do
    report = File.read!("priv/inputs/day01.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)

    assert Task2.compute_depth_increments(report) == 1395
  end
end
