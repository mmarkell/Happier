defmodule HappierWeb.UserController do
  use HappierWeb, :controller

  alias Happier.Accounts
  alias Happier.Accounts.User

  action_fallback(HappierWeb.FallbackController)

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [
      conn,
      conn.params,
      Map.get(get_session(conn, :current_user), :id)
    ])
  end

  def show(conn, %{"id" => id}, current_user_id) do
    cond do
      String.to_integer(id) == current_user_id ->
        user = Accounts.get_user!(id)
        render(conn, "show.json", user: user)

      true ->
        render(conn, "error.json", _params: nil)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user_id) do
    cond do
      String.to_integer(id) == current_user_id ->
        with {:ok, %User{} = user} <-
               Accounts.update_user(get_session(conn, :current_user), user_params) do
          render(conn, "show.json", user: user)
        end

      true ->
        render(conn, "error.json", _params: nil)
    end
  end

  def delete(conn, %{"id" => id}, current_user_id) do
    cond do
      String.to_integer(id) == current_user_id ->
        with {:ok, %User{}} <- Accounts.delete_user(get_session(conn, :current_user)) do
          send_resp(conn, :no_content, "")
        end

      true ->
        render(conn, "error.json", _params: nil)
    end
  end
end
