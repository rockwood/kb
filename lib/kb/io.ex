defmodule Kb.IO do
  def read(path) do
    File.read(path)
  end

  def write(path, rows) do
    File.open(path, [:write, :utf8], fn file ->
      rows
      |> CSV.encode()
      |> Enum.each(&IO.write(file, &1))
    end)
  end
end
