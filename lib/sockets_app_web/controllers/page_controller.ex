defmodule SocketsAppWeb.PageController do
  use SocketsAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
