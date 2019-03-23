defmodule SocketsAppWeb.PageControllerTest do
  use SocketsAppWeb.ConnCase
  alias SocketsApp.Accounts

  describe "GET /" do
    test "it redirects when not logged in", %{conn: conn} do
      conn = get(conn, "/")

      assert redirected_to(conn, 302) =~ "/join"
    end

    test "it renders index page when logged in", %{conn: conn} do
      {:ok, user} = Accounts.create_user(%{name: "Some Name", role: :student})

      conn =
        conn
        |> assign(:current_user, user)

      conn = get(conn, "/")

      assert conn.status == 200
    end
  end
end
