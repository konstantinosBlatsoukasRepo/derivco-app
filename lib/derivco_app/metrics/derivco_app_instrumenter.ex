defmodule DerivcoApp.Metrics.DerivcoAppInstrumenter do
  @moduledoc false

  use Prometheus.Metric

  def setup do
    Counter.declare(
      name: :derivco_app_specific_leuague_season_total,
      help: "Count of total specific leuage requests received"
    )

    Counter.declare(
      name: :derivco_app_all_league_season_pairs_total,
      help: "Count of total all leuage season pairs requests received"
    )

    Histogram.declare(
      name: :derivco_app_all_league_season_pairs_seconds,
      help: "Duration of receiving all league season pairs request"
    )

    Histogram.declare(
      name: :derivco_app_specific_leuague_seconds,
      help: "Duration of receiving a specific league season pair results request"
    )
  end
end
