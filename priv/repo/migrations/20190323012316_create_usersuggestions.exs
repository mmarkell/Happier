defmodule Happier.Repo.Migrations.CreateUsersuggestions do
  use Ecto.Migration

  def change do
    create table(:usersuggestions) do
      add :category, :integer
      add :suggestion, :integer
      add :date_created, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:usersuggestions, [:user_id])
  end
end
