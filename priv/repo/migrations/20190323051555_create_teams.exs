defmodule SocketsApp.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :challenge_id, references(:challenges, on_delete: :delete_all)

      timestamps()
    end

    create index(:teams, [:challenge_id])
  end
end
