defmodule HappierWeb.PassiveDataControllerTest do
  use HappierWeb.ConnCase

  alias Happier.Data
  alias Happier.Data.PassiveData

  @create_attrs %{category: 42, date: "2010-04-17 14:00:00.000000Z", value: %{}}
  @update_attrs %{category: 43, date: "2011-05-18 15:01:01.000000Z", value: %{}}
  @invalid_attrs %{category: nil, date: nil, value: nil}

  def fixture(:passive_data) do
    {:ok, passive_data} = Data.create_passive_data(@create_attrs)
    passive_data
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all passivedata", %{conn: conn} do
      conn = get conn, passive_data_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create passive_data" do
    test "renders passive_data when data is valid", %{conn: conn} do
      conn = post conn, passive_data_path(conn, :create), passive_data: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, passive_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => 42,
        "date" => "2010-04-17 14:00:00.000000Z",
        "value" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, passive_data_path(conn, :create), passive_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update passive_data" do
    setup [:create_passive_data]

    test "renders passive_data when data is valid", %{conn: conn, passive_data: %PassiveData{id: id} = passive_data} do
      conn = put conn, passive_data_path(conn, :update, passive_data), passive_data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, passive_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => 43,
        "date" => "2011-05-18 15:01:01.000000Z",
        "value" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn, passive_data: passive_data} do
      conn = put conn, passive_data_path(conn, :update, passive_data), passive_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete passive_data" do
    setup [:create_passive_data]

    test "deletes chosen passive_data", %{conn: conn, passive_data: passive_data} do
      conn = delete conn, passive_data_path(conn, :delete, passive_data)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, passive_data_path(conn, :show, passive_data)
      end
    end
  end

  defp create_passive_data(_) do
    passive_data = fixture(:passive_data)
    {:ok, passive_data: passive_data}
  end
end
