defmodule CommunityLink.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :organization_id, references(:organizations), null: false

      timestamps()
    end

  end
end
