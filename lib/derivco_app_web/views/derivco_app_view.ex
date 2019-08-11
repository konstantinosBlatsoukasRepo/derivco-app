defmodule DerivcoAppWeb.DerivcoAppView do
  use DerivcoAppWeb, :view

  def render("index.json", %{league_season_pairs: league_season_pairs}) do
    %{"leagueSeasonPairs" => league_season_pairs}
  end

  def render("show.json", %{results: results}) do
    %{"results" => results}
  end
end
