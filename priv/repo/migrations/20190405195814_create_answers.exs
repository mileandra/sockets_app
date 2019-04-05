defmodule SocketsApp.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :value, :text
      add :team_id, references(:teams, on_delete: :nothing)
      add :task_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:team_id])
    create index(:answers, [:task_id])
  end
end
