defmodule DerivcoAppWeb.Schemas do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule LeagueSeasonPair do
    OpenApiSpex.schema(%{
      title: "league season pair",
      description: "A pair that represents an available league with the corresponding season",
      type: :object,
      properties: %{
        league_id: %Schema{type: :string, description: "The id of a league,
        for example the value D1 refers to the first division of the german league"},
        season_id: %Schema{type: :string, description: "The season of the league,
        for example, if the season has the value 201617, that refers to season 2016-2017"}
      },
      example: %{
        "leagueId" => "D1",
        "seasonId" => "201617"
      }
    })
  end

  defmodule LeagueSeasonPairsResponse do
    OpenApiSpex.schema(%{
      title: "all available league-season pairs",
      description: "a list that contains all the availabe league-season pairs",
      type: :object,
      properties: %{
        data: %Schema{
          description: "league-season pairs list",
          type: :array,
          items: LeagueSeasonPair
        }
      },
      example: %{
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
            "leagueId" => "L1",
            "seasonId" => "201618"
          }
        ]
      }
    })
  end

  defmodule Result do
    OpenApiSpex.schema(%{
      title: "a result",
      description: "a result includes information about the final score, half time etc.",
      type: :object,
      properties: %{
        date: %Schema{type: :string, description: "date of the result"},
        home_team: %Schema{type: :string, description: "home team name"},
        away_team: %Schema{type: :string, description: "away team name"},
        ft_home_goals: %Schema{
          type: :string,
          description: "total goals that home team scored in full time"
        },
        ft_away_goals: %Schema{
          type: :string,
          description: "total goals that away team scored in full time"
        },
        ft_result: %Schema{
          type: :string,
          description:
            "full time result: H: for home team win, A: for away team win and D: for draw"
        },
        ht_home_goals: %Schema{
          type: :string,
          description: "total goals that home team scored till half time"
        },
        ht_away_goals: %Schema{
          type: :string,
          description: "total goals that away team scored till half time"
        },
        ht_result: %Schema{
          type: :string,
          description:
            "half time result: H: for home team win, A: for away team win and D: for draw"
        }
      },
      example: %{
        "date" => "19/08/2016",
        "homeTeam" => "La Coruna",
        "awayTeam" => "Eibar",
        "ftHomeGoals" => "2",
        "ftAwayGoals" => "1",
        "ftResult" => "H",
        "htHomeGoals" => "0",
        "htAwayGoals" => "0",
        "htResult" => "D"
      }
    })
  end

  defmodule ResultsResponse do
    OpenApiSpex.schema(%{
      title: "results for a specific leauge-season pair",
      description: "A list that contains all results
        for a specific league and season",
      type: :object,
      properties: %{
        data: %Schema{
          description: "array that contains all the results for a specifc league-season pair",
          type: :array,
          items: Result
        }
      },
      example: %{
        "results" => [
          %{
            "date" => "19/08/2016",
            "homeTeam" => "La Coruna",
            "awayTeam" => "Eibar",
            "ftHomeGoals" => "2",
            "ftAwayGoals" => "1",
            "ftResult" => "H",
            "htHomeGoals" => "0",
            "htAwayGoals" => "0",
            "htResult" => "D"
          },
          %{
            "date" => "20/08/2016",
            "homeTeam" => "Barcelona",
            "awayTeam" => "Almeria",
            "ftHomeGoals" => "2",
            "ftAwayGoals" => "1",
            "ftResult" => "H",
            "htHomeGoals" => "0",
            "htAwayGoals" => "0",
            "htResult" => "D"
          }
        ]
      }
    })
  end
end
