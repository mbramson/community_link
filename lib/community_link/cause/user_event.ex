defmodule CommunityLink.Cause.UserEvent do
  use Ecto.Schema
  import Ecto.Changeset

  alias CommunityLink.Cause.Event


  schema "users_events" do
    belongs_to :user, CommunityLink.Account.User
    belongs_to :event, Event

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:user_id, :event_id])
    |> validate_required([:user_id, :event_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:event)
  end
end
