defmodule Booktracker.Repo do
  use Ecto.Repo,
    otp_app: :booktracker,
    adapter: Ecto.Adapters.Postgres
end
