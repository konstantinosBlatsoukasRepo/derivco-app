defmodule DerivcoAppWeb.Router do
  use DerivcoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug(OpenApiSpex.Plug.PutApiSpec, module: DerivcoApp.ApiSpec)
  end

  pipeline :proto_api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through(:browser)
    get("/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi")
  end

  scope "/api" do
    pipe_through(:api)

    resources("/leauge-season-pairs", DerivcoAppWeb.DerivcoAppController, only: [:index])

    get(
      "/leauge-season-pairs/:league_id/:season_id/results",
      DerivcoAppWeb.DerivcoAppController,
      :show
    )

    get("/openapi", OpenApiSpex.Plug.RenderSpec, :show)
  end

  scope "/api" do
    pipe_through(:proto_api)

    get(
      "/proto/leauge-season-pairs/:league_id/:season_id/results",
      DerivcoAppWeb.DerivcoAppProtoController,
      :show
    )
  end
end
