defmodule Kb do
  defstruct output_path: "", rows: []

  def convert(path) do
    output_path = "#{Path.rootname(path)}.csv"

    with {:ok, body} <- Kb.IO.read(path),
         {:ok, rows} <- Kb.Converter.run(body),
         {:ok, _} <- Kb.IO.write(output_path, rows) do
      {:ok, %__MODULE__{output_path: output_path, rows: rows}}
    end
  end
end
