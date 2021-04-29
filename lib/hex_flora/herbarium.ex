defmodule HexFlora.Herbarium do
  alias HexFlora.Herbarium.Specimen

  use NimblePublisher,
    build: Specimen,
    from: Application.app_dir(:hex_flora, "priv/herbarium/*.md"),
    as: :specimens,
    highlighters: []

  # The @specimens variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @specimens Enum.sort_by(@specimens, & &1.name)

  # And finally export them
  def list_specimens, do: @specimens

  def get_specimen_by_id!(id) do
    Enum.find(list_specimens(), &(&1.id == id))
  end
end
