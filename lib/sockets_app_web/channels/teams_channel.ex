defmodule SocketsAppWeb.TeamsChannel do
  use SocketsAppWeb, :channel
  # alias SocketsAppWeb.Endpoint
  alias SocketsApp.{Accounts, Challenges, Repo}
  alias SocketsAppWeb.{Presence, Endpoint}

  def join("teams:lobby", _payload, socket) do
    if authorized?(socket) do
      user = get_user(socket.assigns.user_id)
      send(self(), {:after_join, user, "lobby"})
      {:ok, %{current_user: user}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("teams:" <> team_id, _payload, socket) do
    if authorized?(socket) do
      user = get_user(socket.assigns.user_id)
      send(self(), {:after_join, user, team_id})
      {:ok, team_info(team_id), socket}
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
  # broadcast to everyone in the current topic (teams:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("answer_update", %{"answer" => %{"id" => answer_id, "value" => value}}, socket) do
    case Challenges.update_answer(answer_id, %{value: value}) do
      {:ok, answer} ->
        IO.inspect(answer)
        Endpoint.broadcast("teams:#{answer.team_id}", "answer_updated", %{"answer" => answer, "update_by" => socket.assigns.user_id})

      {:error, err} ->
        IO.inspect(err)
    end
    {:noreply, socket}
  end

  def handle_in("send_chat_message", %{"message" => message}, socket) do
    user = get_user(socket.assigns.user_id)
    Endpoint.broadcast("teams:#{user.team_id}", "new_chat_message", %{from: user.name, message: message})
    {:noreply, socket}
  end

  def handle_info({:after_join, user, team}, socket) do
    push(socket, "presence_state", Presence.list(socket))
    Presence.track(socket.transport_pid, "teams:#{team}", "#{user.id}", %{
      user_id: user.id,
      role: user.role,
      team_id: team,
      online_at: inspect(System.system_time(:second))
    })
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(socket) do
    Map.has_key?(socket.assigns, :user_id)
  end

  defp get_user(id) do
    Accounts.get_user!(id)
  end

  defp team_info(team_id) do
    team = Challenges.get_team!(team_id) |> Repo.preload(:users)
    challenge = Challenges.get_challenge!(team.challenge_id) |> Repo.preload([:tasks])
    answers = Challenges.list_answers(%{team: team, tasks: challenge.tasks})
    %{team: team, challenge: challenge, answers: answers}
  end
end
