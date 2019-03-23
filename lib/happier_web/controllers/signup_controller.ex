defmodule HappierWeb.SignUpController do
  use HappierWeb, :controller
  alias Happier.Accounts

  action_fallback(HappierWeb.FallbackController)

  def create(conn, %{"user" => user_params}) do
    result = Accounts.create_user(user_params)

    case result do
      {:error, reason} ->
        conn
        |> put_status(401)
        |> json(%{message: reason})

      {:ok, _user} ->
        conn
        |> put_status(:created)
        |> redirect(to: "/api/v1/login")
    end
  end

  def getdefault(conn, _) do
    conn
    |> json(%{username: random_string(15), password: random_string(15)})
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
