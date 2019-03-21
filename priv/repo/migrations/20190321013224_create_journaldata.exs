defmodule Happier.Repo.Migrations.CreateJournaldata do
  use Ecto.Migration

  def change do
    create table(:journaldata) do
      add :entry, :string
      add :analysis, :map
      add :date, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:journaldata, [:user_id])
  end
end
