defmodule SocketsApp.Challenges.TeamUser do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Challenges.Team
  alias SocketsApp.Accounts.User
  alias SocketsApp.ValidationHelpers

  schema "teams_users" do
    belongs_to :team, Team
    belongs_to :user, User
  end

  @doc false
  def changeset(team_user, attrs) do
    team_user
    |> cast(attrs, [:team_id, :user_id])
    |> ValidationHelpers.validate_belongs_to(:team)
    |> ValidationHelpers.validate_belongs_to(:user)
  end
end
