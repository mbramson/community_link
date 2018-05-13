defmodule CommunityLink.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CommunityLink.Cause.Event
  alias CommunityLink.Cause.UserEvent


  schema "users" do
    field :name, :string
    field :points, :integer
    many_to_many :events, Event, join_through: UserEvent

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :points])
    |> validate_required([:name, :points])
  end
end
