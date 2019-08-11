defmodule DerivcoApp.Repo do
  use Ecto.Repo,
    otp_app: :derivco_app,
    adapter: Ecto.Adapters.Postgres
end
