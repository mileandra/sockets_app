defmodule SocketsApp.Challenges.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :value, :string
    belongs_to :team, SocketsApp.Challenges.Team
    belongs_to :task, SocketsApp.Challenges.Task

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:value, :team_id, :task_id])
  end
end
