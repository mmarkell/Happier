defmodule Happier.Data.JournalData do
  use Ecto.Schema
  import Ecto.Changeset
  alias Happier.NLP_UTIL

  schema "journaldata" do
    field(:analysis, :map)
    field(:date, :utc_datetime)
    field(:entry, :string)
    field(:user_id, :id)

    timestamps()
  end

  def changeset(journal_data, attrs) do
    journal_data
    |> cast(attrs, [:entry, :analysis, :date, :user_id])
    |> validate_required([:user_id, :entry, :date])
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:entry])
    |> analyze_entry()
  end

  defp analyze_entry(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{entry: entry}} ->
        put_change(changeset, :analysis, get_analysis(entry))

      _ ->
        changeset
    end
  end

  defp get_analysis(entry) do
    %{
      entities: NLP_UTIL.get_entities(%{entry: entry}),
      sentiment: NLP_UTIL.get_sentiment(%{entry: entry}),
      entity_sentiment: NLP_UTIL.get_entities_sentiment(%{entry: entry})
    }
  end
end
