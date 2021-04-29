defmodule HexFloraWeb.SpecimenController do
  use HexFloraWeb, :controller

  alias HexFlora.Herbarium

  def index(conn, _params) do
    render(conn, "index.html", specimens: Herbarium.list_specimens())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", specimen: Herbarium.get_specimen_by_id!(id))
  end
end
