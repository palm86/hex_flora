defmodule HexFlora.Herbarium.VegetationType do
  defmodule Builder do
    @enforce_keys [:id, :name, :has_image?, :body]
    defstruct [:id, :name, :has_image?, :body, :public?]

    def build(filename, attrs, body) do
      id = filename |> Path.basename() |> Path.rootname()
      struct!(__MODULE__, [id: id, body: body] ++ Map.to_list(attrs))
    end
  end

  use NimblePublisher,
    build: Builder,
    from: Application.app_dir(:hex_flora, "priv/vegetation_types/*.md"),
    as: :vegetation_types,
    highlighters: []

  # The @vegetation_types variable is first defined by NimblePublisher.
  # Let's further modify it.
  @vegetation_types Enum.sort_by(@vegetation_types, & &1.name)
  @vegetation_types Enum.filter(@vegetation_types, & &1.public?)

  def list, do: @vegetation_types

  def get_by_id!(id) do
    Enum.find(list(), &(&1.id == id))
  end
end
