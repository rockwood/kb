defmodule Kb.CLI do
  alias Kb.{Importer}

  @moduledoc """
  usage: kb [options]
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
    IO.puts @moduledoc
    System.halt(0)
  end
  def process({path}) do
    Kb.convert(path)
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
