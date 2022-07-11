defmodule Kb.CLI do
  @moduledoc """
  usage: kb export_file.xls
  """

  @switches [help: :boolean]
  @aliases [h: :help]

  def main(argv) do
    argv
    |> parse_argv
    |> process
  end

  def parse_argv(args) do
    args
    |> OptionParser.parse(switches: @switches, aliases: @aliases)
    |> handle_parse
  end

  def process(:help) do
    IO.puts(@moduledoc)
    System.halt(0)
  end

  def process({path}) do
    case Kb.convert(path) do
      {:ok, export} ->
        IO.puts("Converted #{length(export.rows) - 1} rows to: #{export.output_path}")
        System.halt(0)

      {:error, reason} ->
        IO.puts("Error: #{reason}")
        System.halt(-1)
    end
  end

  defp handle_parse({[help: true], _, _}) do
    :help
  end

  defp handle_parse({_, [path], _}) do
    {path}
  end

  defp handle_parse(_) do
    :help
  end
end
