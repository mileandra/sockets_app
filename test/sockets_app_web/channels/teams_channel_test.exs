defmodule SocketsAppWeb.TeamsChannelTest do
  use SocketsAppWeb.ChannelCase, async: false
  alias SocketsApp.Accounts
  alias SocketsAppWeb.Presence

  setup do
    {:ok, user} = Accounts.create_user(%{name: "Some Name", role: :student})

    {:ok, _, socket} =
      socket(SocketsAppWeb.UserSocket, "user_id", %{user_id: user.id})
      |> subscribe_and_join(SocketsAppWeb.TeamsChannel, "teams:lobby")

      :timer.sleep(100)
    {:ok, socket: socket}
  end

  test "join creates presence", %{socket: socket} do
    assert presences = Presence.list("teams:lobby")
    assert length(Map.keys(presences)) == 1
    [{_key, %{user: u}}] = Map.to_list(presences)
    assert u.id == socket.assigns.user_id
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to teams:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
