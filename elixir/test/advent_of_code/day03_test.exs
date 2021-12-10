defmodule AdventOfCode.Day03Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day03.{Task1, Task2}

  test "task 1 example" do
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]

    assert Task1.compute_gamma_epsilon_product(input) == 198
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day03.txt")
    assert Task1.compute_gamma_epsilon_product(input) == 3148794
  end

  test "task 2 example" do
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]

    assert Task2.compute_oxygen_co2_ratings_product(input) == 230
  end

  test "task 2 input" do
    input = Input.read_lines_from_file("priv/inputs/day03.txt")
    assert Task2.compute_oxygen_co2_ratings_product(input) == 2795310
  end
end
