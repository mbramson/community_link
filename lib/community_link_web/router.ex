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
    get "/organizations/:org_id/send_message", ContactUsersController, :index
    resources "/organizations", OrganizationController
    resources "/events", EventController
    resources "/users_events", UserEventController
    post "/fake_login/:user_id", FakeUserLoginController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", CommunityLinkWeb do
  #   pipe_through :api
  # end
end
