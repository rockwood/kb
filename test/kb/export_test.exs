defmodule Kb.ExportTest do
  use ExUnit.Case

  describe "read!" do
    test "sets the name and body" do
      export = Kb.Export.read!("test/fixtures/example.xls")
      assert export.output_path =~ "test/fixtures/example.csv"
      assert export.body
    end
  end
end
