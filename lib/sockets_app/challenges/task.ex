defmodule SocketsApp.Challenges.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias SocketsApp.Challenges.Challenge

  schema "tasks" do
    field :question, :string

    belongs_to :challenge, Challenge

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:question, :challenge_id])
    |> validate_required([:question])
  end
end
