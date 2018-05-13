defmodule CommunityLink.Cause.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :description, :string
    field :name, :string
    field :points, :integer
    belongs_to :organization, CommunityLink.Cause.Organization

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
