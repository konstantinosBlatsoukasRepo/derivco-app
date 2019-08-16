defmodule DerivcoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias DerivcoApp.Metrics.{DerivcoAppInstrumenter, PrometheusExporter}

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      # DerivcoApp.Repo,
      # Start the endpoint when the application starts
      DerivcoAppWeb.Endpoint,
      # resource endpoint which serves the prometheus server with metrics
      {Plug.Cowboy, scheme: :http, plug: PrometheusExporter, options: [port: 8081]}
      # Starts a worker by calling: DerivcoApp.Worker.start_link(arg)
      # {DerivcoApp.Worker, arg},
    ]

    # application metrics initialization
    PrometheusExporter.setup()
    DerivcoAppInstrumenter.setup()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DerivcoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DerivcoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
