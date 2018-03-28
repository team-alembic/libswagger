defmodule Swagger.BulkParserTest do
  use ExUnit.Case, async: true

  test "can parse all the sample swagger files" do
    Path.wildcard("test/schemas/*.swagger")
    |> Enum.each(fn filename ->
      IO.puts("Processsing `#{filename}`...")

      {:ok, schema} =
        filename
        |> File.read!()
        |> Swagger.parse_yaml()

      # IO.inspect(schema)
      filename
      |> String.replace_trailing(".swagger", ".exs")
      |> File.write!(inspect(schema, pretty: true))
    end)
  end
end
