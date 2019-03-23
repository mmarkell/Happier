defmodule HappierWeb.SessionController do
  use HappierWeb, :controller

  alias Happier.Accounts
  alias Happier.Accounts.Guardian

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    result = Accounts.authenticate_user(username, password)

    case result do
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> json(%{message: "invalid login"})

      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, %{})

        conn
        |> put_session(:current_user, user)
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{data: %{token: jwt}})
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/api/v1/login")
  end

  def remember_me(conn, user) do
    Guardian.Plug.remember_me(conn, user, Guardian.Plug.current_claims(conn), [])
  end
end
