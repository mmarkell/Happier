defmodule Happier.Data.JournalData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "journaldata" do
    field(:analysis, :map)
    field(:date, :utc_datetime)
    field(:entry, :string)
    field(:user_id, :id)

    timestamps()
  end

  @doc false
  def changeset(journal_data, attrs) do
    journal_data
    |> cast(attrs, [:entry, :analysis, :date, :user_id])
    |> validate_required([:entry, :date])
  end
end
