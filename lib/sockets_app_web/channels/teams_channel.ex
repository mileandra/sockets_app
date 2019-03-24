defmodule SocketsAppWeb.TeamsChannel do
  use SocketsAppWeb, :channel
  alias SocketsAppWeb.Endpoint
  alias SocketsApp.Accounts
  alias SocketsAppWeb.Presence

  def join("teams:lobby", _payload, socket) do
    if authorized?(socket) do
      send(self(), :after_join)
      Endpoint.broadcast("teacher:lobby", "student_joined", %{user: get_user(socket.assigns.user_id)})
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
  # broadcast to everyone in the current topic (teams:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    user = get_user(socket.assigns.user_id)
    {:ok, _} = Presence.track(socket.transport_pid, "teams:lobby", "#{user.id}", %{
      user_id: user.id,
      user_name: user.name,
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
end
