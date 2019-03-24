defmodule HappierWeb.JournalDataController do
  use HappierWeb, :controller

  alias Happier.Data
  alias Happier.Data.JournalData
  alias Happier.NLP_UTIL
  action_fallback(HappierWeb.FallbackController)

  def index(conn, _params) do
    journaldata = Data.list_journaldata()
    render(conn, "index.json", journaldata: journaldata)
  end

  def create(conn, %{"journal_data" => journal_data_params}) do
    with {:ok, %JournalData{} = journal_data} <- Data.create_journal_data(journal_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", journal_data_path(conn, :show, journal_data))
      |> render("show.json", journal_data: journal_data)
    end
  end

  def show(conn, %{"id" => id}) do
    journal_data = Data.get_journal_data!(id)
    render(conn, "show.json", journal_data: journal_data)
  end

  def update(conn, %{"id" => id, "journal_data" => journal_data_params}) do
    journal_data = Data.get_journal_data!(id)

    with {:ok, %JournalData{} = journal_data} <-
           Data.update_journal_data(journal_data, journal_data_params) do
      render(conn, "show.json", journal_data: journal_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    journal_data = Data.get_journal_data!(id)

    with {:ok, %JournalData{}} <- Data.delete_journal_data(journal_data) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_sentiment(conn, %{"id" => id}) do
    journal_data = Data.get_journal_data!(id)
    render(conn, "sentiment.json", journal_data: NLP_UTIL.get_sentiment(journal_data))
  end

  def get_entities(conn, %{"id" => id}) do
    journal_data = Data.get_journal_data!(id)
    render(conn, "entities.json", journal_data: NLP_UTIL.get_entities(journal_data))
  end

  def get_entity_sentiment(conn, %{"id" => id}) do
    journal_data = Data.get_journal_data!(id)
    render(conn, "entitiysentiment.json",
      journal_data: NLP_UTIL.get_entities_sentiment(journal_data)
    )
  end
end
