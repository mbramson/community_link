defmodule CommunityLink.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :owner_id, references(:users), null: false

      timestamps()
    end

  end
end
