defmodule DerivcoApp.Protobuf.LeagueSeasonPairsDef do
  use Protobuf, """
    message LeagueSeasonPair {
      required string awayTeam = 1;
      required string date = 2;
      required string ftAwayGoals = 3;
      required string ftHomeGoals = 4;
      required string ftResult = 5;
      required string homeTeam = 6;
      required string htAwayGoals = 7;
      required string htHomeGoals = 8;
      required string htResult = 9;
    }

    message Response {
      repeated LeagueSeasonPair leagueSeasonPairs = 1;
    }
  """
end
