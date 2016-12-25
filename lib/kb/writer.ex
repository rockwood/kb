defmodule Kb.Writer do
  @headers ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow"]

  def write_csv(export) do
    file = File.open!("#{export.name}.csv", [:write, :utf8])
    export.rows
    |> CSV.encode(headers: @headers)
    |> Enum.each(&IO.write(file, &1))
  end
end
