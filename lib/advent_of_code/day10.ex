defmodule AdventOfCode.Day10 do
  @spec compute_syntax_error_score(list(String.t())) :: integer()
  def compute_syntax_error_score(input) when is_list(input) do
    input
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&find_errors/1)
    |> Enum.map(&score_first_error/1)
    |> Enum.sum()
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

  @spec find_errors(charlist()) :: charlist()
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

    {_, errors} = Enum.reduce(input, {[], []}, reducer)

    errors
  end

  @spec score_first_error(charlist()) :: integer()
  defp score_first_error([]), do: 0
  defp score_first_error([?) | _]), do: 3
  defp score_first_error([?] | _]), do: 57
  defp score_first_error([?} | _]), do: 1197
  defp score_first_error([?> | _]), do: 25137
end
