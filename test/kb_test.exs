defmodule KbTest do
  use ExUnit.Case
  doctest Kb

  test "convert" do
    Kb.convert("test/fixtures/example.xls")
  end
end
