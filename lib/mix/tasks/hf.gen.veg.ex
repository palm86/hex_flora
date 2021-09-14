defmodule Mix.Tasks.Hf.Gen.Veg do
  @shortdoc "Generates a vegetation type markdown document."

  @moduledoc """
  Generates a vegetation type markdown document.
      mix hf.gen.veg South Hex Sandstone Fynbos
  The first argument is vegetation type name.

  Overall, this generator will add the following files to `priv/vegetation_types`:
    * a markdown file in `priv/vegetation_types/name.md`
    * it will expect an image at `assets/static/images/name.jpg`
  """
  use Mix.Task

  @keys [:name]

  @doc false
  def run(args) do
    bindings =
      @keys
      |> Enum.zip(args)

    id = bindings[:name] |> String.downcase() |> String.replace(" ", "_")

    rendered = EEx.eval_file("priv/templates/vegetation_type.md", bindings)
    File.write("priv/vegetation_types/#{id}.md", rendered)
  end
end
