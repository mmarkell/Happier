defmodule HappierWeb.PassiveDataController do
  use HappierWeb, :controller

  alias Happier.Data
  alias Happier.Data.PassiveData

  action_fallback HappierWeb.FallbackController

  def index(conn, _params) do
    passivedata = Data.list_passivedata()
    render(conn, "index.json", passivedata: passivedata)
  end

  def create(conn, %{"passive_data" => passive_data_params}) do
    with {:ok, %PassiveData{} = passive_data} <- Data.create_passive_data(passive_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", passive_data_path(conn, :show, passive_data))
      |> render("show.json", passive_data: passive_data)
    end
  end

  def show(conn, %{"id" => id}) do
    passive_data = Data.get_passive_data!(id)
    render(conn, "show.json", passive_data: passive_data)
  end

  def update(conn, %{"id" => id, "passive_data" => passive_data_params}) do
    passive_data = Data.get_passive_data!(id)

    with {:ok, %PassiveData{} = passive_data} <- Data.update_passive_data(passive_data, passive_data_params) do
      render(conn, "show.json", passive_data: passive_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    passive_data = Data.get_passive_data!(id)
    with {:ok, %PassiveData{}} <- Data.delete_passive_data(passive_data) do
      send_resp(conn, :no_content, "")
    end
  end
end
