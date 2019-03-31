defmodule SocketsAppWeb.Admin.SessionController do
  @moduledoc """
  This module is responsible for managing the "login" of the users
  """
  use SocketsAppWeb, :controller
  alias SocketsApp.Accounts
  alias SocketsAppWeb.Auth
  require Logger

  def new(conn, _params \\ %{}) do
    conn
    |> render("new.html")
  end

  def create(conn, %{"session" => %{"name" => name}}) do
    case Accounts.get_teacher(name) do
      nil ->
        login_error(conn)

      user ->
        login(conn, user)
    end
  end

  def delete(conn, _params \\ %{}) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "See ya!")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp login(conn, user) do
    conn
    |> Auth.login(user)
    |> put_flash(:info, "Hey there!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp login_error(conn) do
    conn
    |> put_flash(:error, "Unable to join")
    |> render("new.html")
  end
end
