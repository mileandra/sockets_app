defmodule SocketsApp.Challenges.TeamBuilder do
  @moduledoc """
  Responsible for building teams.
  It will try to pair users if they are dividible by 2.
  If there is a user left, it will place him into the last team created
  """
  alias SocketsApp.{Challenges, Accounts}

  @doc """
  builds teams from a list of users
  """
  def build(%Challenges.Challenge{id: challenge_id}, users) do
    teams =
      users
      |> pair_users()
      |> create_teams(challenge_id)

    {:ok, teams}
  end
  def build(challenge_id, users) when is_integer(challenge_id) do
    build(Challenges.get_challenge!(challenge_id), users)
  end

  defp pair_users(users) do
    users
    |> Enum.chunk_every(2, 2, [])
    |> Enum.reverse()
    |> maybe_create_team_with_3()
    |> Enum.reverse()
  end

  defp maybe_create_team_with_3([head]), do: [head]
  defp maybe_create_team_with_3([head|tail]) do
    if Enum.count(head) == 1 do
      user = Enum.at(head, 0)
      tail
      |> add_user_to_team(user)
    else
      [head|tail]
    end
  end

  defp add_user_to_team([team|tail], user) do
    team = [user|team]
    [team|tail]
  end

  defp create_teams(users, challenge_id, results \\ [])
  defp create_teams([team_users|tail], challenge_id, results) do
    {:ok, team} = Challenges.create_team(%{challenge_id: challenge_id})
    Enum.each(team_users, fn u ->
        Accounts.update_user(u, %{team_id: team.id})
    end)
    team = SocketsApp.Repo.preload(team, :users)

    create_teams(tail, challenge_id, results ++ [team])
  end
  defp create_teams([], _, results), do: results

end
