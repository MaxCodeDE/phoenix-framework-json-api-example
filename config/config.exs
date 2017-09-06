# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_framework_json_api_example,
  ecto_repos: [PhoenixFrameworkJsonApiExample.Repo]

# Configures the endpoint
config :phoenix_framework_json_api_example, PhoenixFrameworkJsonApiExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ciek/Ub1AXeOMRTS6S8Lviz0mc1vykxojCUk7pp4O8r+5V4PdmR6L/yKj0QWoarw",
  render_errors: [view: PhoenixFrameworkJsonApiExampleWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoenixFrameworkJsonApiExample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Konfiguriert JSON Api
config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
