defmodule HexFloraWeb.Router do
  use HexFloraWeb, :router

  pipeline :browser do
    plug :put_root_layout, {HexFloraWeb.LayoutView, :root}
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HexFloraWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/flora-of-the-hex", PageController, :flora
    get "/about-hexflora", PageController, :about
    get "/how-to-contribute", PageController, :contribute
    resources "/specimens", SpecimenController, only: [:show, :index]
    resources "/vegetation_types", VegetationTypeController, only: [:show, :index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HexFloraWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: HexFloraWeb.Telemetry
    end
  end
end
