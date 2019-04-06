defmodule SocketsApp.Challenges.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Accounts.User
  alias SocketsApp.Challenges.{Challenge, Answer}
  alias SocketsApp.ValidationHelpers

  schema "teams" do
    belongs_to :challenge, Challenge, on_replace: :update
    has_many :users, User
    has_many :tasks, through: [:challenge, :tasks]
    has_many :answers, Answer

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:challenge_id])
    |> ValidationHelpers.validate_belongs_to(:challenge)
    |> cast_assoc(:users)
    |> cast_assoc(:answers)
  end
end
