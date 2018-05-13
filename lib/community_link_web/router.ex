defmodule CommunityLinkWeb.Router do
  use CommunityLinkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CommunityLinkWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/organizations", OrganizationController
    resources "/events", EventController
    resources "/users_events", UserEventController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CommunityLinkWeb do
  #   pipe_through :api
  # end
end
