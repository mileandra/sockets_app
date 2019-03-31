defmodule SocketsApp.Challenges.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Accounts.User
  alias SocketsApp.Challenges.{Challenge}
  alias SocketsApp.ValidationHelpers

  @derive {Jason.Encoder, only: [:id, :challenge_id]}

  schema "teams" do
    belongs_to :challenge, Challenge, on_replace: :update
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:challenge_id])
    |> ValidationHelpers.validate_belongs_to(:challenge)
    |> cast_assoc(:users)
  end
end
