defmodule CommunityLink.Cause.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias CommunityLink.Cause.Organization
  alias CommunityLink.Cause.UserEvent
  alias CommunityLink.Account.User

  schema "events" do
    field :description, :string
    field :name, :string
    field :points, :integer
    belongs_to :organization, Organization
    many_to_many :users, User, join_through: UserEvent

    timestamps()
  end

  @fields ~w(name description points organization_id)a

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
