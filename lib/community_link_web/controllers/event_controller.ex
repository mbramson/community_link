defmodule CommunityLinkWeb.EventController do
  use CommunityLinkWeb, :controller

  alias CommunityLink.Cause
  alias CommunityLink.Cause.Event

  def index(conn, _params) do
    events = Cause.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    organizations = CommunityLink.Cause.list_organizations()
    changeset = Cause.change_event(%Event{})
    render(conn, "new.html", changeset: changeset, organizations: organizations)
  end

  def create(conn, %{"event" => event_params}) do
    case Cause.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, %Ecto.Changeset{} = changeset} ->
        organizations = CommunityLink.Cause.list_organizations()
        render(conn, "new.html", changeset: changeset, organizations: organizations)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Cause.get_event!(id)
    logged_in_user = get_session(conn, "current_user")
    render(conn, "show.html", event: event, user: logged_in_user)
  end

  def edit(conn, %{"id" => id}) do
    organizations = CommunityLink.Cause.list_organizations()
    event = Cause.get_event!(id)
    changeset = Cause.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset, organizations: organizations)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Cause.get_event!(id)

    case Cause.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, %Ecto.Changeset{} = changeset} ->
        organizations = CommunityLink.Cause.list_organizations()
        render(conn, "edit.html", event: event, changeset: changeset, organizations: organizations)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Cause.get_event!(id)
    {:ok, _event} = Cause.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: event_path(conn, :index))
  end
end
