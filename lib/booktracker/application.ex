defmodule Booktracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BooktrackerWeb.Telemetry,
      Booktracker.Repo,
      {DNSCluster, query: Application.get_env(:booktracker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Booktracker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Booktracker.Finch},
      # Start a worker by calling: Booktracker.Worker.start_link(arg)
      # {Booktracker.Worker, arg},
      # Start to serve requests, typically the last entry
      BooktrackerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Booktracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BooktrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
