# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :happier,
  ecto_repos: [Happier.Repo]

# Configures the endpoint
config :happier, HappierWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0i9Mll/ao1KV9hzNLKt0vcihmhmcKrSpjV36NcE8tLhBGapt4951xav1uGDu0KxJ",
  render_errors: [view: HappierWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Happier.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :happier, Happier.Accounts.Guardian,
  issuer: "Happier",
  ttl: {30, :days},
  verify_issuer: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
