defmodule DerivcoAppWeb.DerivcoAppControllerTest do
  use DerivcoAppWeb.ConnCase

  test "get /api/leauge-season-pairs/ responds with all available league-season pairs", %{
    conn: conn
  } do
    response =
      conn
      |> get("/api/leauge-season-pairs/")
      |> json_response(200)

    expected = %{
      "leagueSeasonPairs" => [
        %{
          "leagueId" => "D1",
          "seasonId" => "201617"
        },
        %{
          "leagueId" => "E0",
          "seasonId" => "201617"
        },
        %{
          "leagueId" => "SP1",
          "seasonId" => "201516"
        },
        %{
          "leagueId" => "SP1",
          "seasonId" => "201617"
        },
        %{
          "leagueId" => "SP2",
          "seasonId" => "201516"
        },
        %{
          "leagueId" => "SP2",
          "seasonId" => "201617"
        }
      ]
    }

    assert response == expected
  end

  test "get /api/leauge-season-pairs/SP1/201617/results responds with all results for leauge SP1 and season 2016-17",
       %{
         conn: conn
       } do
    total_results =
      conn
      |> get("/api/leauge-season-pairs/SP1/201617/results")
      |> json_response(200)
      |> Map.get("results")
      |> Enum.count()

    expected = 380

    assert total_results == expected
  end

  test "get /api/leauge-season-pairs/SP1/A01617/results responds with http status 422, since the season_id must be integer",
       %{
         conn: conn
       } do
    response =
      conn
      |> get("/api/leauge-season-pairs/SP1/A201617/results")

    expected_http_status = 422

    assert response.status == expected_http_status
  end

  test "get /api/leauge-season-pairs/SP144/201617/results responds with http status 404, since the no results found for this league",
       %{
         conn: conn
       } do
    response =
      conn
      |> get("/api/leauge-season-pairs/SP144/201617/results")

    expected_http_status = 404

    assert response.status == expected_http_status
  end
end
