defmodule Happier.Repo.Migrations.CreatePassivedata do
  use Ecto.Migration

  def change do
    create table(:passivedata) do
      add :category, :integer
      add :value, :map
      add :date, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:passivedata, [:user_id])
  end
end
