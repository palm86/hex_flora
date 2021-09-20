defmodule HexFloraWeb.VegetationTypeController do
  use HexFloraWeb, :controller

  alias HexFlora.Herbarium.VegetationType

  def index(conn, _params) do
    render(conn, "index.html", vegetation_types: VegetationType.list())
  end

  def show(conn, %{"id" => id}) do
    conn
    |> assign(:specimens, HexFlora.Herbarium.Specimen.list_by_vegetation_type_id(id))
    |> render("show.html", vegetation_type: VegetationType.get_by_id!(id))
  end
end
