defmodule HappierWeb.SelfEvaluationControllerTest do
  use HappierWeb.ConnCase

  alias Happier.Data
  alias Happier.Data.SelfEvaluation

  @create_attrs %{category: 42, date: "2010-04-17 14:00:00.000000Z", value: %{}}
  @update_attrs %{category: 43, date: "2011-05-18 15:01:01.000000Z", value: %{}}
  @invalid_attrs %{category: nil, date: nil, value: nil}

  def fixture(:self_evaluation) do
    {:ok, self_evaluation} = Data.create_self_evaluation(@create_attrs)
    self_evaluation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all selfevaluations", %{conn: conn} do
      conn = get(conn, self_evaluation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create self_evaluation" do
    test "renders self_evaluation when data is valid", %{conn: conn} do
      conn = post(conn, self_evaluation_path(conn, :create), self_evaluation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, self_evaluation_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "category" => 42,
               "date" => "2010-04-17 14:00:00.000000Z",
               "value" => %{}
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, self_evaluation_path(conn, :create), self_evaluation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update self_evaluation" do
    setup [:create_self_evaluation]

    test "renders self_evaluation when data is valid", %{
      conn: conn,
      self_evaluation: %SelfEvaluation{id: id} = self_evaluation
    } do
      conn =
        put(conn, self_evaluation_path(conn, :update, self_evaluation),
          self_evaluation: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, self_evaluation_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "category" => 43,
               "date" => "2011-05-18 15:01:01.000000Z",
               "value" => %{}
             }
    end

    test "renders errors when data is invalid", %{conn: conn, self_evaluation: self_evaluation} do
      conn =
        put(conn, self_evaluation_path(conn, :update, self_evaluation),
          self_evaluation: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete self_evaluation" do
    setup [:create_self_evaluation]

    test "deletes chosen self_evaluation", %{conn: conn, self_evaluation: self_evaluation} do
      conn = delete(conn, self_evaluation_path(conn, :delete, self_evaluation))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, self_evaluation_path(conn, :show, self_evaluation))
      end)
    end
  end

  defp create_self_evaluation(_) do
    self_evaluation = fixture(:self_evaluation)
    {:ok, self_evaluation: self_evaluation}
  end
end
