defmodule Kb.Converter do
  def run(export) do
    rows =
      export.body
      |> Floki.find("table table")
      |> Enum.take(-1)
      |> Floki.find("tr")
      |> extract_rows()

    Map.put(export, :rows, rows)
  end

  defp extract_rows([_header_row | body_rows]) do
    Enum.map(body_rows, &extract_row/1)
  end

  defp extract_row({"tr", _attrs, columns}) do
    [date, _time, _desc, payee, memo, amount_withdrawn, amount_deposited, _balance, _type] = columns

    %{
      "Date" => date |> Floki.text() |> parse_date(),
      "Payee" => payee |> Floki.text() |> parse_text(),
      "Category" => "",
      "Memo" => memo |> Floki.text() |> parse_text(),
      "Outflow" => amount_withdrawn |> Floki.text() |> parse_amount(),
      "Inflow" => amount_deposited |> Floki.text() |> parse_amount()
    }
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
