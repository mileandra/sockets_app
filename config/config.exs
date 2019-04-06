# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sockets_app,
  ecto_repos: [SocketsApp.Repo]

# Configures the endpoint
config :sockets_app, SocketsAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UmgyXgQXnLzWu1Qw/uwTloY2xuVjll/iJ44lLc0Llw7lXzFPFQqoxL6O4FMgoUcj",
  render_errors: [view: SocketsAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SocketsApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
