defmodule CommunityLink.Cause.Organization do
  use Ecto.Schema
  import Ecto.Changeset


  schema "organizations" do
    field :name, :string
    field :description, :string
    belongs_to :owner, CommunityLink.Account.User

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :description, :owner_id])
    |> validate_required([:name, :description])
  end
end
