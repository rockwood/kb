defmodule Kb.Converter do
  def run(export) do
    rows = export.body
    |> Floki.find("table table")
    |> Enum.take(-1) # Remove the blank table
    |> Floki.find("tr")
    |> extract_rows

    Map.put(export, :rows, rows)
  end

  defp extract_rows([_header_row | body_rows]) do
    Enum.map(body_rows, &extract_row/1)
  end

  defp extract_row({"tr", _attrs, columns}) do
    [date, _time, _desc, payee, memo, amount_withdrawn, amount_deposited, _balance, _type] = columns

    %{
      "Date" => Floki.text(date) |> parse_date,
      "Payee" => Floki.text(payee) |> parse_text,
      "Category" => "",
      "Memo" => Floki.text(memo) |> parse_text,
      "Outflow" => Floki.text(amount_withdrawn) |> parse_amount,
      "Inflow" => Floki.text(amount_deposited) |> parse_amount,
    }
  end

  defp parse_date(string) do
    string
    |> String.split(".")
    |> Enum.reverse
    |> Enum.join("/")
  end

  defp parse_text(string) do
    String.strip(string)
  end

  defp parse_amount(string) do
    {won, _extra} = string
    |> String.replace(",", "")
    |> Float.parse

    (won / 1000) |> :erlang.float_to_binary(decimals: 2)
  end
end
