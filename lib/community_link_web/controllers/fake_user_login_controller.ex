defmodule CommunityLinkWeb.FakeUserLoginController do
  use CommunityLinkWeb, :controller

  alias CommunityLink.Account

  def create(conn, %{"user_id" => user_id}) do
    user = Account.get_user!(user_id)

    conn
    |> put_session(:current_user, user)
    |> put_flash(:info, "Now logged in as #{user.name}")
    |> redirect(to: user_path(conn, :index))
  end
end
