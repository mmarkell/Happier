defmodule HappierWeb.UserSuggestionControllerTest do
  use HappierWeb.ConnCase

  alias Happier.Insights
  alias Happier.Insights.UserSuggestion

  @create_attrs %{category: 42, date_created: "2010-04-17 14:00:00.000000Z", suggestion: 42}
  @update_attrs %{category: 43, date_created: "2011-05-18 15:01:01.000000Z", suggestion: 43}
  @invalid_attrs %{category: nil, date_created: nil, suggestion: nil}

  def fixture(:user_suggestion) do
    {:ok, user_suggestion} = Insights.create_user_suggestion(@create_attrs)
    user_suggestion
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all usersuggestions", %{conn: conn} do
      conn = get conn, user_suggestion_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_suggestion" do
    test "renders user_suggestion when data is valid", %{conn: conn} do
      conn = post conn, user_suggestion_path(conn, :create), user_suggestion: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, user_suggestion_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => 42,
        "date_created" => "2010-04-17 14:00:00.000000Z",
        "suggestion" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_suggestion_path(conn, :create), user_suggestion: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_suggestion" do
    setup [:create_user_suggestion]

    test "renders user_suggestion when data is valid", %{conn: conn, user_suggestion: %UserSuggestion{id: id} = user_suggestion} do
      conn = put conn, user_suggestion_path(conn, :update, user_suggestion), user_suggestion: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, user_suggestion_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => 43,
        "date_created" => "2011-05-18 15:01:01.000000Z",
        "suggestion" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, user_suggestion: user_suggestion} do
      conn = put conn, user_suggestion_path(conn, :update, user_suggestion), user_suggestion: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_suggestion" do
    setup [:create_user_suggestion]

    test "deletes chosen user_suggestion", %{conn: conn, user_suggestion: user_suggestion} do
      conn = delete conn, user_suggestion_path(conn, :delete, user_suggestion)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, user_suggestion_path(conn, :show, user_suggestion)
      end
    end
  end

  defp create_user_suggestion(_) do
    user_suggestion = fixture(:user_suggestion)
    {:ok, user_suggestion: user_suggestion}
  end
end
