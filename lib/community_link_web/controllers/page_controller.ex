defmodule CommunityLinkWeb.PageController do
  use CommunityLinkWeb, :controller

  def index(conn, _params) do
    logged_in_user = get_session(conn, "current_user")

    conn
    |> Plug.Conn.assign(:current_user, logged_in_user)
    |> render("index.html")
  end
end
