defmodule SocketsApp.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :name, :string

      timestamps()
    end

  end
end
