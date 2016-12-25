defmodule Kb do
  def convert(path) do
    path
    |> Kb.Export.read!
    |> Kb.Converter.run
    |> Kb.Writer.write_csv
  end
end
