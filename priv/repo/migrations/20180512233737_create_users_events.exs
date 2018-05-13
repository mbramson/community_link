defmodule CommunityLink.Repo.Migrations.CreateUsersEvents do
  use Ecto.Migration

  def change do
    create table(:users_events) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:users_events, [:user_id])
    create index(:users_events, [:event_id])
  end
end
