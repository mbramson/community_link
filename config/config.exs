# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :community_link,
  ecto_repos: [CommunityLink.Repo]

# Configures the endpoint
config :community_link, CommunityLinkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "45jbnO+h/812CLs65EABzvZZlWbWSQS385Ec7sv5MJ1W27+ZhX0E6DZycX2Sd61J",
  render_errors: [view: CommunityLinkWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CommunityLink.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
