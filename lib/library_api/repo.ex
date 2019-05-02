defmodule LibraryApi.Repo do
  use Ecto.Repo,
    otp_app: :library_api,
    adapter: Ecto.Adapters.Postgres
end
