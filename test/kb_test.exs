defmodule KbTest do
  use ExUnit.Case
  doctest Kb

  setup do
    {:ok, export} = Kb.convert("test/fixtures/example.xls")
    on_exit(fn -> File.rm!(export.output_path) end)
    {:ok, export: export}
  end

  test "convert", %{export: export} do
    assert File.read!(export.output_path) =~ "25/12/2016,레오니다스,,,0.10,0.00\r"
  end
end
