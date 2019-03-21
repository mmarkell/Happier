defmodule HappierWeb.JournalDataControllerTest do
  use HappierWeb.ConnCase

  alias Happier.Data
  alias Happier.Data.JournalData

  @create_attrs %{analysis: %{}, date: "2010-04-17 14:00:00.000000Z", entry: "some entry"}
  @update_attrs %{analysis: %{}, date: "2011-05-18 15:01:01.000000Z", entry: "some updated entry"}
  @invalid_attrs %{analysis: nil, date: nil, entry: nil}

  def fixture(:journal_data) do
    {:ok, journal_data} = Data.create_journal_data(@create_attrs)
    journal_data
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all journaldata", %{conn: conn} do
      conn = get conn, journal_data_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create journal_data" do
    test "renders journal_data when data is valid", %{conn: conn} do
      conn = post conn, journal_data_path(conn, :create), journal_data: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, journal_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "analysis" => %{},
        "date" => "2010-04-17 14:00:00.000000Z",
        "entry" => "some entry"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, journal_data_path(conn, :create), journal_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update journal_data" do
    setup [:create_journal_data]

    test "renders journal_data when data is valid", %{conn: conn, journal_data: %JournalData{id: id} = journal_data} do
      conn = put conn, journal_data_path(conn, :update, journal_data), journal_data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, journal_data_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "analysis" => %{},
        "date" => "2011-05-18 15:01:01.000000Z",
        "entry" => "some updated entry"}
    end

    test "renders errors when data is invalid", %{conn: conn, journal_data: journal_data} do
      conn = put conn, journal_data_path(conn, :update, journal_data), journal_data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete journal_data" do
    setup [:create_journal_data]

    test "deletes chosen journal_data", %{conn: conn, journal_data: journal_data} do
      conn = delete conn, journal_data_path(conn, :delete, journal_data)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, journal_data_path(conn, :show, journal_data)
      end
    end
  end

  defp create_journal_data(_) do
    journal_data = fixture(:journal_data)
    {:ok, journal_data: journal_data}
  end
end
