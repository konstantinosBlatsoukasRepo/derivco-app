defmodule DerivcoApp.LeagueSeasonPairs do
  @moduledoc """
  This module is responsible for generating all the data that the app provides in compilation time.

  Two functions are provided

  - get_league_season_pairs/0: lists all the available league/season pairs
  - get_league_season_results/2: for a specific league/season pair you get a results list
  for this pair. All the functions are generated in compilation time
  """

  use PrometheusDecorator

  alias NimbleCSV.RFC4180, as: CSV

  @external_resource Path.join(__DIR__, "Data.csv")
  @data_contents @external_resource |> File.read!() |> CSV.parse_string()

  @league_season_pairs @data_contents
                       |> Enum.reduce(MapSet.new(), fn
                         [_, league_id, season_id | _], acc ->
                           MapSet.put(acc, {league_id, season_id})
                       end)
                       |> Enum.map(fn {league, season} ->
                         %{"leagueId" => league, "seasonId" => season}
                       end)

  @decorate histogram_observe(:derivco_app_all_league_season_pairs_seconds)
  @decorate counter_inc(:derivco_app_specific_leuague_season_total)
  def get_league_season_pairs(), do: @league_season_pairs

  @results_per_league_season_pair @data_contents
                                  |> Enum.reduce(%{}, fn
                                    [
                                      _,
                                      league_id,
                                      season_id,
                                      date,
                                      home_team,
                                      away_team,
                                      ft_home_goals,
                                      ft_away_goals,
                                      ft_result,
                                      ht_home_goals,
                                      ht_away_goals,
                                      ht_result
                                    ],
                                    acc ->
                                      fixture = %{
                                        "date" => date,
                                        "homeTeam" => home_team,
                                        "awayTeam" => away_team,
                                        "ftHomeGoals" => ft_home_goals,
                                        "ftAwayGoals" => ft_away_goals,
                                        "ftResult" => ft_result,
                                        "htHomeGoals" => ht_home_goals,
                                        "htAwayGoals" => ht_away_goals,
                                        "htResult" => ht_result
                                      }

                                      if Map.has_key?(acc, {league_id, season_id}) do
                                        previous_fixtures = Map.get(acc, {league_id, season_id})
                                        updated_fixtures = [fixture | previous_fixtures]
                                        Map.put(acc, {league_id, season_id}, updated_fixtures)
                                      else
                                        Map.put(acc, {league_id, season_id}, [fixture])
                                      end
                                  end)

  for {league_season, results} <- @results_per_league_season_pair do
    {league_id, season_id} = league_season

    @decorate histogram_observe(:derivco_app_all_league_season_pairs_seconds)
    @decorate counter_inc(:derivco_app_specific_leuague_season_total)
    def get_league_season_results(unquote(league_id), unquote(season_id)),
      do: unquote(Macro.escape(results))
  end

  def get_league_season_results(_, _), do: []
end
