defmodule SocketsApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :question, :text
      add :challenge_id, references(:challenges, on_delete: :delete_all)

      timestamps()
    end
    create index(:tasks, [:challenge_id])
  end
end
