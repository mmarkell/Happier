defmodule HappierWeb.UserControllerTest do
  use HappierWeb.ConnCase

  alias Happier.Accounts
  alias Happier.Accounts.User

  @create_attrs %{
    email: "some email",
    password_hash: "some password_hash",
    phone_number: "some phone_number",
    registered_date: "2010-04-17 14:00:00.000000Z",
    tier: 42,
    username: "some username"
  }
  @update_attrs %{
    email: "some updated email",
    password_hash: "some updated password_hash",
    phone_number: "some updated phone_number",
    registered_date: "2011-05-18 15:01:01.000000Z",
    tier: 43,
    username: "some updated username"
  }
  @invalid_attrs %{
    email: nil,
    password_hash: nil,
    phone_number: nil,
    registered_date: nil,
    tier: nil,
    username: nil
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => "some email",
               "password_hash" => "some password_hash",
               "phone_number" => "some phone_number",
               "registered_date" => "2010-04-17T14:00:00.000000Z",
               "tier" => 42,
               "username" => "some username"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => "some updated email",
               "password_hash" => "some updated password_hash",
               "phone_number" => "some updated phone_number",
               "registered_date" => "2011-05-18T15:01:01.000000Z",
               "tier" => 43,
               "username" => "some updated username"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, user_path(conn, :show, user))
      end)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
