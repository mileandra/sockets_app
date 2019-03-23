defmodule SocketsApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :role, RoleEnum

    belongs_to :team, SocketsApp.Challenges.Team
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :role, :team_id])
    |> validate_required([:name, :role])
    |> cast_assoc(:team)
  end
end
