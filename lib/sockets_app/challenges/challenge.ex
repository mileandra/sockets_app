defmodule SocketsApp.Challenges.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Challenges.{Task, Team}


  schema "challenges" do
    field :name, :string

    has_many :tasks, Task
    has_many :teams, Team
    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:tasks)
  end
end
