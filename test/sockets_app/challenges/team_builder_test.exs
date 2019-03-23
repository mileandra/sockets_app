defmodule SocketsApp.TeamBuilderTest do
  use SocketsApp.DataCase
  alias SocketsApp.{Accounts, Challenges, Challenges.TeamBuilder}

  @user_atts %{name: "Some Name", role: :student}
  @challenge_atts %{name: "Some Name"}

  defp user_fixture(params \\ %{}) do
    {:ok, user} =
      params
      |> Enum.into(@user_atts)
      |> Accounts.create_user()

    user
  end

  def challenge_fixture(params \\ %{}) do
    {:ok, challenge} =
      params
      |> Enum.into(@challenge_atts)
      |> Challenges.create_challenge()

    challenge
  end

  describe "build_teams" do
    test "when number of users passed is even, it will generate teams of 2" do
      users = Enum.map(1..10, fn _ ->
        user_fixture()
      end)

      challenge = challenge_fixture()

      assert {:ok, teams} = TeamBuilder.build(challenge, users)
      assert length(teams) == 5

      team = Enum.at(teams, 0)
      assert %Challenges.Team{users: users} = team
      assert length(users) == 2
      assert team.challenge_id == challenge.id
      user = Enum.at(users, 0)
      assert user.team_id == team.id
    end

    test "when number of users is uneven, it will put 3 users in last team" do
      users = Enum.map(1..5, fn _ ->
        user_fixture()
      end)

      challenge = challenge_fixture()

      assert {:ok, teams} = TeamBuilder.build(challenge, users)
      assert length(teams) == 2
      assert team = Enum.at(teams, 1)
      assert length(team.users) == 3
    end
  end
end
