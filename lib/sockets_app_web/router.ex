defmodule SocketsAppWeb.Router do
  use SocketsAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SocketsAppWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SocketsAppWeb do
    pipe_through :browser

    get "/join", SessionController, :new
    post "/join", SessionController, :create
    get "/leave", SessionController, :delete
  end

  scope "/", SocketsAppWeb do
    pipe_through [:browser, :authenticate_user]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SocketsAppWeb do
  #   pipe_through :api
  # end
end
