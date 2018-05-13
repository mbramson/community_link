defmodule :"Elixir.CommunityLink.Repo.Migrations.Add-points-to-events" do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :points, :integer, default: 0, null: false
    end
  end
end
