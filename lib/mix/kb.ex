defmodule Mix.Tasks.Kb do
  defmodule Convert do
    use Mix.Task
    @shortdoc "Convert KB export to YNAB"

    def run([path]) do
      Kb.convert(path)
    end
  end
end
