defmodule AdventOfCode.Day10Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day10

  test "task 1 example" do
    input = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
    |> String.split("\n", trim: true)

    assert Day10.compute_syntax_error_score(input) == 26397
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day10.txt")
    assert Day10.compute_syntax_error_score(input) == 369105
  end

  test "task 2 example" do
    input = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
    |> String.split("\n", trim: true)

    assert Day10.compute_completion_score(input) == 288957
  end

  test "task 2 input" do
    input = Input.read_lines_from_file("priv/inputs/day10.txt")
    assert Day10.compute_completion_score(input) == 3999363569
  end
end
