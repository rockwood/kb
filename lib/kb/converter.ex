defmodule Kb.Converter do
  @headers ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow"]

  def run(body) do
    with {:ok, doc} <- Floki.parse_document(body) do
      doc
      |> Floki.find("table table")
      |> Enum.drop(1)
      |> Floki.find("tr")
      |> Enum.drop(1)
      |> extract_rows([@headers])
    end
  end

  defp extract_rows([], results), do: {:ok, Enum.reverse(results)}

  defp extract_rows([head | tail], results) do
    case head do
      {"tr", _, [date, _time, _desc, payee, memo, outflow, inflow, _bal, _type]} ->
        row =
          [
            date |> Floki.text() |> parse_date(),
            payee |> Floki.text() |> parse_text(),
            "",
            memo |> Floki.text() |> parse_text(),
            outflow |> Floki.text() |> parse_amount(),
            inflow |> Floki.text() |> parse_amount()
          ]

        extract_rows(tail, [row | results])

      _ ->
        {:error, "Invalid row (#{inspect(head)})"}
    end
  end

  defp parse_date(string) do
    string
    |> String.split(".")
    |> Enum.reverse()
    |> Enum.join("/")
  end

  defp parse_text(string) do
    String.trim(string)
  end

  defp parse_amount(string) do
    {won, _extra} =
      string
      |> String.replace(",", "")
      |> Float.parse()

    (won / 1000) |> :erlang.float_to_binary(decimals: 2)
  end
end
