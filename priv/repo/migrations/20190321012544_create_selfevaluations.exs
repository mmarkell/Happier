defmodule Happier.Repo.Migrations.CreateSelfevaluations do
  use Ecto.Migration

  def change do
    create table(:selfevaluations) do
      add :category, :integer
      add :value, :map
      add :date, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:selfevaluations, [:user_id])
  end
end
