defmodule Kb.Export do
  defstruct name: "", body: "", rows: []

  def read!(pathname) do
    path = Path.expand(pathname)
    struct(__MODULE__, %{body: File.read!(path), name: Path.basename(path, ".xls")})
  end
end
