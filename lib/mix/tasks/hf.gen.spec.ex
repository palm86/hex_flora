defmodule Mix.Tasks.Hf.Gen.Spec do
  @shortdoc "Generates a specimen markdown document."

  @moduledoc """
  Generates a specimen markdown document.
      mix hf.gen.spec Apocynaceae Stapelia grandiflora
  The first argument is the family name followed by the genus
  and the species.

  Overall, this generator will add the following files to `priv/herbarium`:
    * a markdown file in `priv/herbarium/genus_species.md`
    * it will expect an image at `assets/static/images/genus_species.jpg`
  """
  use Mix.Task

  @keys [:family, :genus, :species]

  @doc false
  def run(args) do
    bindings =
      @keys
      |> Enum.zip(args)

    rendered = EEx.eval_file("priv/templates/specimen.md", bindings)
    File.write("priv/specimens/#{String.downcase(bindings[:genus])}_#{bindings[:species]}.md", rendered)
  end
end
