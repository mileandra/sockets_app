defmodule SocketsApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    RoleEnum.create_type
    create table(:users) do
      add :name, :string
      add :role, RoleEnum.type()

      timestamps()
    end

  end
end
