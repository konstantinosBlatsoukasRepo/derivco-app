defmodule DerivcoApp.ApiSpec do
  alias OpenApiSpex.{OpenApi, Server, Info, Paths}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        Server.from_endpoint(DerivcoAppWeb.Endpoint)
      ],
      info: %Info{
        title: "Derivco App",
        version: "1.0"
      },
      # populate the paths from a phoenix router
      paths: Paths.from_router(DerivcoAppWeb.Router)
    }
    # discover request/response schemas from path specs
    |> OpenApiSpex.resolve_schema_modules()
  end
end
