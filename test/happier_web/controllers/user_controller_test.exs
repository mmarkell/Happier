defmodule HappierWeb.UserControllerTest do
  use HappierWeb.ConnCase
  alias Happier.Accounts

  @michael_user %{
    username: "ilovechicken444",
    password: "mypassword",
    email: "michaelmarkell1@gmail.com"
  }

  @invalid_user %{
    username: "",
    password: ""
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@michael_user)
    user
  end

  describe "auth" do
    setup [:create_user]

    test "valid login gets a jwt", %{conn: conn, user: user} do
      response =
        conn
        |> Plug.Test.init_test_session(current_user_id: user.id)
        |> post(session_path(conn, :login),
          user: %{username: user.username, password: user.password}
        )
        |> json_response(200)

      assert %{"token" => jwt} = response["data"]
    end

    test "invalid login does not get a jwt", %{conn: conn, user: user} do
      response =
        conn
        |> Plug.Test.init_test_session(current_user_id: user.id)
        |> post(session_path(conn, :login),
          user: %{username: @invalid_user.username, password: @invalid_user.password}
        )
        |> json_response(401)

      assert %{"message" => "invalid login"} = response
    end

    test "invalid login does not give you access", %{conn: conn, user: user} do
      response =
        conn
        |> Plug.Test.init_test_session(current_user_id: user.id)
        |> get(user_path(conn, :show, user.id))

      assert response = "unauthenticated"
    end

    # TODO: figure out how to put two conns in a single test or something
    # test "valid login does give you access", %{conn: conn, user: user} do
    #   response =
    #     conn
    #     |> Plug.Test.init_test_session(current_user_id: user.id)
    #     |> post(session_path(conn, :login),
    #       user: %{username: user.username, password: user.password}
    #     )
    #     |> json_response(200)

    #   jwt = response["data"]["token"]
    #   bearer = "Bearer " <> jwt

    #   assign(conn, :token, bearer)
    #   IO.puts(conn)

    #   response =
    #     conn
    #     |> Plug.Test.init_test_session(current_user_id: user.id)
    #     |> get(user_path(conn, :show, user.id))
    #     |> json_response(200)

    #   assert %{"user" => "hi"} = response
    # end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
