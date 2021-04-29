defmodule HexFlora.Herbarium.Specimen do
  @enforce_keys [:id, :name, :rank, :common_names, :taxonomy, :body, :description]
  defstruct [:id, :name, :rank, :common_names, :taxonomy, :body, :description]

  def build(filename, attrs, body) do
    id = filename |> Path.basename() |> Path.rootname()
    [description, body] = String.split(body, "<!-- read more -->", parts: 2)
    struct!(__MODULE__, [id: id, description: description, body: body] ++ Map.to_list(attrs))
  end
end
