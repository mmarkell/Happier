defmodule HappierWeb.SessionController do
  use HappierWeb, :controller

  alias Happier.Accounts
  alias Happier.Accounts.User
  alias Happier.Accounts.Guardian

  def new(conn, _) do
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/api/v1/")
    else
      render(conn, action: session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    Accounts.UserManager.authenticate_user(username, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/api/v1/users")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> new(%{})
  end
end
