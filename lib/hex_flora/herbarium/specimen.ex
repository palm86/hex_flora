defmodule HexFlora.Herbarium.Specimen do
  defmodule Builder do
    @enforce_keys [:id, :name, :rank, :taxonomy, :body, :description]
    defstruct [:id, :name, :rank, :taxonomy, :body, :description, vegetation_type_ids: [], common_names: []]

    def build(filename, attrs, body) do
      id = filename |> Path.basename() |> Path.rootname()
      [description, body] = String.split(body, "<!-- read more -->", parts: 2)
      struct!(__MODULE__, [id: id, description: description, body: body] ++ Map.to_list(attrs))
    end
  end

  use NimblePublisher,
    build: Builder,
    from: Application.app_dir(:hex_flora, "priv/specimens/*.md"),
    as: :specimens,
    highlighters: []

  # The @specimens variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all specimens.
  @specimens Enum.sort_by(@specimens, & &1.name)

  def list(), do: @specimens

  def list_by_vegetation_type_id(vegetation_type_id) do
    Enum.filter(list(), &(vegetation_type_id in &1.vegetation_type_ids))
  end

  def get_by_id!(id) do
    Enum.find(list(), &(&1.id == id))
  end
end
