defmodule HexFloraWeb.PageController do
  use HexFloraWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def flora(conn, _params) do
    conn
    |> render("flora.html")
  end

  def about(conn, _params) do
    conn
    |> render("about.html")
  end

  def contribute(conn, _params) do
    conn
    |> render("contribute.html")
  end
end
