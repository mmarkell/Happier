defmodule Happier.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:password_hash, :string)
      add(:phone_number, :string)
      add(:email, :string, null: true)
      add(:tier, :integer)
      add(:registered_date, :utc_datetime)

      timestamps()
    end

    create(unique_index(:users, [:username]))
  end
end
