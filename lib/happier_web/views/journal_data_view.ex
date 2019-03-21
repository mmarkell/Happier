defmodule HappierWeb.JournalDataView do
  use HappierWeb, :view
  alias HappierWeb.JournalDataView

  def render("index.json", %{journaldata: journaldata}) do
    %{data: render_many(journaldata, JournalDataView, "journal_data.json")}
  end

  def render("show.json", %{journal_data: journal_data}) do
    %{data: render_one(journal_data, JournalDataView, "journal_data.json")}
  end

  def render("journal_data.json", %{journal_data: journal_data}) do
    %{id: journal_data.id,
      entry: journal_data.entry,
      analysis: journal_data.analysis,
      date: journal_data.date}
  end
end
