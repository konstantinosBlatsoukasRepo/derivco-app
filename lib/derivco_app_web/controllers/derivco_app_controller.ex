defmodule DerivcoAppWeb.DerivcoAppController do
  use DerivcoAppWeb, :controller

  import OpenApiSpex.Operation, only: [response: 3]

  alias DerivcoApp.LeagueSeasonPairs
  alias DerivcoAppWeb.Schemas.{ResultsResponse, LeagueSeasonPairsResponse}
  alias OpenApiSpex.Operation

  plug(OpenApiSpex.Plug.Cast)
  plug(OpenApiSpex.Plug.Validate)

  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  def index_operation() do
    %Operation{
      tags: ["league_season_pairs"],
      summary: "league season pairs",
      description: "list of all available leagues and seasons",
      operationId: "DerivcoAppController.index",
      responses: %{
        200 =>
          response("league season pairs response", "application/json", LeagueSeasonPairsResponse)
      }
    }
  end

  def index(conn, _params) do
    league_season_pairs = LeagueSeasonPairs.get_league_season_pairs()
    render(conn, "index.json", league_season_pairs: league_season_pairs)
  end

  def show_operation() do
    %Operation{
      tags: ["league_season_pairs"],
      summary: "all results for a specific league and season",
      description: "list of all results for a specific league and season",
      operationId: "DerivcoAppController.show",
      parameters: [
        Operation.parameter(:league_id, :path, :string, "league_id",
          example: "E0",
          required: true
        ),
        Operation.parameter(:season_id, :path, :integer, "season id",
          example: 201_617,
          required: true
        )
      ],
      responses: %{
        200 => response("results", "application/json", ResultsResponse)
      }
    }
  end

  def show(conn, _params) do
    league_id = Map.get(conn.path_params, "league_id")
    season_id = Map.get(conn.path_params, "season_id")
    results = LeagueSeasonPairs.get_league_season_results(league_id, season_id)

    do_show(conn, results)
  end

  defp do_show(conn, []) do
    resp(conn, 404, Jason.encode!(%{message: "no results found"}))
  end

  defp do_show(conn, results), do: render(conn, "show.json", results: results)
end
