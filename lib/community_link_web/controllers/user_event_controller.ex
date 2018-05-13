defmodule CommunityLinkWeb.UserEventController do
  use CommunityLinkWeb, :controller

  alias CommunityLink.Cause
  alias CommunityLink.Cause.UserEvent

  def index(conn, _params) do
    users_events = Cause.list_users_events()
    render(conn, "index.html", users_events: users_events)
  end

  def new(conn, _params) do
    users = CommunityLink.Account.list_users()
    events = CommunityLink.Cause.list_events()
    changeset = Cause.change_user_event(%UserEvent{})
    render(conn, "new.html", changeset: changeset, users: users, events: events)
  end

  def create(conn, %{"user_event" => user_event_params}) do
    case Cause.create_user_event(user_event_params) do
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "User event created successfully.")
        |> redirect(to: user_event_path(conn, :show, user_event))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_event = Cause.get_user_event!(id)
    render(conn, "show.html", user_event: user_event)
  end

  def edit(conn, %{"id" => id}) do
    users = CommunityLink.Account.list_users()
    events = CommunityLink.Cause.list_events()
    user_event = Cause.get_user_event!(id)
    changeset = Cause.change_user_event(user_event)
    render(conn, "edit.html", user_event: user_event, changeset: changeset, users: users, events: events)
  end

  def update(conn, %{"id" => id, "user_event" => user_event_params}) do
    user_event = Cause.get_user_event!(id)

    case Cause.update_user_event(user_event, user_event_params) do
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "User event updated successfully.")
        |> redirect(to: user_event_path(conn, :show, user_event))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_event: user_event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_event = Cause.get_user_event!(id)
    {:ok, _user_event} = Cause.delete_user_event(user_event)

    conn
    |> put_flash(:info, "User event deleted successfully.")
    |> redirect(to: user_event_path(conn, :index))
  end
end
