defmodule HexFloraWeb.SpecimenController do
  use HexFloraWeb, :controller

  alias HexFlora.Herbarium.Specimen

  def index(conn, _params) do
    render(conn, "index.html", specimens: Specimen.list())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", specimen: Specimen.get_by_id!(id))
  end
end
