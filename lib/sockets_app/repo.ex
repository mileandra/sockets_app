defmodule SocketsApp.Repo do
  use Ecto.Repo,
    otp_app: :sockets_app,
    adapter: Ecto.Adapters.Postgres
end
