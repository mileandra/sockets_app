defmodule SocketsAppWeb.TeacherChannelTest do
  use SocketsAppWeb.ChannelCase
  alias SocketsApp.Accounts

  setup do
    {:ok, user} = Accounts.create_user(%{name: "Some Name", role: :teacher})

    {:ok, _, socket} =
      socket(SocketsAppWeb.UserSocket, "user_id", %{user_id: user.id})
      |> subscribe_and_join(SocketsAppWeb.TeacherChannel, "teacher:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to teacher:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
