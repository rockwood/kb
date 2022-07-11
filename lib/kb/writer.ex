defmodule Kb.Writer do
  @headers ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow"]

  def write_csv(export) do
    File.open!(export.output_path, [:write, :utf8], fn file ->
      export.rows
      |> CSV.encode(headers: @headers)
      |> Enum.each(&IO.write(file, &1))
    end)

    {:ok, export}
  end
end
