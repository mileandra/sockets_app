defmodule SocketsAppWeb.TeacherChannel do
  use SocketsAppWeb, :channel

  alias SocketsApp.{Accounts, Challenges, Repo}
  alias SocketsAppWeb.Endpoint

  def join("teacher", _payload, socket) do
    if authorized_teacher?(socket) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (teacher:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # List challenges
  def handle_in("list_challenges", _payload, socket) do
    challenges = Challenges.list_challenges()
    {:reply, {:ok, %{challenges: challenges}}, socket}
  end

  # Pair the teams
  def handle_in("pair_teams", %{"challenge_id" => ch_id, "user_ids" => user_ids}, socket) do
    challenge = Challenges.get_challenge!(ch_id)
    users = Accounts.list_users(user_ids)
    {:ok, teams} = Challenges.TeamBuilder.build(challenge, users)
    teams
    |> create_initial_answers(challenge)
    |> notify_of_pairing()
    {:reply, {:ok, %{teams: teams, challenge: challenge}}, socket}
  end

  defp create_initial_answers(teams, challenge) do
    challenge = Repo.preload(challenge, [:tasks])

    Enum.map(teams, fn team ->
      Enum.each(challenge.tasks, fn t ->
        Challenges.create_answer(%{
          team_id: team.id,
          task_id: t.id,
          value: ""
        }) |> IO.inspect()
      end)
      team
    end)
  end

  # Send a notification to each user about what team he or she is in
  defp notify_of_pairing(teams) do
    Enum.map(teams, fn t ->
      Enum.map(t.users, fn u ->
        Endpoint.broadcast("user:#{u.id}", "paired", %{team_id: t.id})
      end)
    end)
  end

  # Add authorization logic here as required.
  defp authorized?(socket) do
    Map.has_key?(socket.assigns, :user_id)
  end

  defp authorized_teacher?(socket) do
    if authorized?(socket) do
      user = Accounts.get_user!(socket.assigns.user_id)
      user.role == :teacher
    else
      false
    end
  end
end
