defmodule SocketsAppWeb.Auth do
  @moduledoc """
  Ensures we have a user session
  """
  import Plug.Conn
  import Phoenix.Controller

  alias SocketsApp.{Accounts}
  alias SocketsAppWeb.Router.Helpers, as: Routes
  alias SocketsAppWeb.Endpoint

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    cond do
      user = conn.assigns[:current_user] -> put_current_user(conn, user)
      user = user_id && Accounts.get_user(user_id) -> put_current_user(conn, user)
      true -> assign(conn, :current_user, nil)
    end
  end

  @doc """
  Retrieves a user model and saves the user id in the session
  """
  def login(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  Deletes the user from the session and drops it
  """
  def logout(conn) do
    conn
    |> disconnect_from_channel()
    |> put_current_user(nil)
    |> clear_session()
    |> configure_session(drop: true)
  end

  @doc """
  Handles access restriction
  """
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  defp put_current_user(conn, nil) do
    conn
    |> assign(:current_user, nil)
    |> assign(:user_token, nil)
  end
  defp put_current_user(conn, user) do
    token = Phoenix.Token.sign(conn, "user_socket", user.id)
    conn
    |> assign(:current_user, user)
    |> assign(:user_token, token)
  end

  # Ensures the socket connection is closed
  defp disconnect_from_channel(%{assigns: %{current_user: nil}} = conn), do: conn
  defp disconnect_from_channel(%{assigns: %{current_user: user}} = conn) do
    Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
    conn
  end
  defp disconnect_from_channel(conn), do: conn

end
