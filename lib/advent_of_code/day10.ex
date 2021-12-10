defmodule AdventOfCode.Day10 do
  @spec compute_syntax_error_score(list(String.t())) :: integer()
  def compute_syntax_error_score(input) when is_list(input) do
    input
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&find_errors/1)
    |> Enum.map(&score_first_error/1)
    |> Enum.sum()
  end

  @spec compute_completion_score(list(String.t())) :: integer()
  def compute_completion_score(input) when is_list(input) do
    scores = input
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&find_errors/1)
    |> Enum.map(&score_completion/1)
    |> Enum.reject(&(&1 == 0))
    |> Enum.sort()

    Enum.at(scores, trunc(length(scores) / 2))
  end

  defguard is_opening(char) when char in [?(, ?[, ?{, ?<]
  defguard is_closing(char) when char in [?), ?], ?}, ?>]

  defguard matches(opening, closing)
           when {opening, closing} in [
                  {?(, ?)},
                  {?[, ?]},
                  {?{, ?}},
                  {?<, ?>}
                ]

  @spec find_errors(charlist()) :: {charlist(), charlist()}
  defp find_errors(input) when is_list(input) do
    reducer = fn
      char, {stack, errors} when is_opening(char)      -> {[char | stack], errors}
      char, {stack, errors} when is_closing(char)      ->
        case stack do
          []                                     -> {stack, errors ++ [char]}
          [head | rest] when matches(head, char) -> {rest,  errors}
          [_ | rest]                             -> {rest,  errors ++ [char]}
        end
    end

    Enum.reduce(input, {[], []}, reducer)
  end

  @spec score_first_error({charlist(), charlist()}) :: integer()
  defp score_first_error({_, []}), do: 0
  defp score_first_error({_, [?) | _]}), do: 3
  defp score_first_error({_, [?] | _]}), do: 57
  defp score_first_error({_, [?} | _]}), do: 1197
  defp score_first_error({_, [?> | _]}), do: 25137

  @spec score_completion({charlist(), charlist()}) :: integer()
  def score_completion({stack, []}) do
    stack
    |> Enum.reduce(0, fn
      ?(, total -> total * 5 + 1
      ?[, total -> total * 5 + 2
      ?{, total -> total * 5 + 3
      ?<, total -> total * 5 + 4
    end)
  end

  def score_completion(_), do: 0
end
