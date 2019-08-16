defmodule DerivcoAppWeb.DerivcoAppProtoController do
  use DerivcoAppWeb, :controller

  alias DerivcoApp.LeagueSeasonPairs

  alias DerivcoApp.Protobuf.LeagueSeasonPairsDef.{
    LeagueSeasonPair,
    Response
  }

  def show(conn, _params) do
    league_id = Map.get(conn.path_params, "league_id")
    season_id = Map.get(conn.path_params, "season_id")
    results = LeagueSeasonPairs.get_league_season_results(league_id, season_id)

    do_proto_show(conn, results)
  end

  defp do_proto_show(conn, []) do
    send_resp(conn, 404, "Not found")
  end

  defp do_proto_show(conn, results) do
    t_results = Enum.map(results, &transfor_to_proto_pair(&1))
    proto_response = Response.new(leagueSeasonPairs: t_results)
    response = Protobuf.Serializable.serialize(proto_response)
    send_resp(conn, 200, response)
  end

  defp transfor_to_proto_pair(result) do
    %{
      "awayTeam" => awayTeam,
      "date" => date,
      "ftAwayGoals" => ftAwayGoals,
      "ftHomeGoals" => ftHomeGoals,
      "ftResult" => ftResult,
      "homeTeam" => homeTeam,
      "htAwayGoals" => htAwayGoals,
      "htHomeGoals" => htHomeGoals,
      "htResult" => htResult
    } = result

    LeagueSeasonPair.new(
      awayTeam: awayTeam,
      date: date,
      ftAwayGoals: ftAwayGoals,
      ftHomeGoals: ftHomeGoals,
      ftResult: ftResult,
      homeTeam: homeTeam,
      htAwayGoals: htAwayGoals,
      htHomeGoals: htHomeGoals,
      htResult: htResult
    )
  end
end
