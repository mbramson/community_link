defmodule CommunityLink.Cause.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :description, :string
    field :name, :string
    belongs_to :organization, CommunityLink.Cause.Organization

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :organization_id])
    |> validate_required([:name, :description])
  end
end
