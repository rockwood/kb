defmodule Kb.Export do
  defstruct output_path: "", body: "", rows: []

  def read!(pathname) do
    path = Path.expand(pathname)
    struct(__MODULE__, %{body: File.read!(path), output_path: "#{Path.rootname(path)}.csv"})
  end
end
