defmodule SocketsApp.Challenges.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Challenges.Challenge
  alias SocketsApp.ValidationHelpers

  schema "teams" do
    belongs_to :challenge, Challenge, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:challenge_id])
    |> ValidationHelpers.validate_belongs_to(:challenge)
  end
end
