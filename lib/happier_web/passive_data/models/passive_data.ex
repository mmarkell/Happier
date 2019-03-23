defmodule Happier.Data.PassiveData do
  use Ecto.Schema
  import Ecto.Changeset


  schema "passivedata" do
    field :category, :integer
    field :date, :utc_datetime
    field :value, :map
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(passive_data, attrs) do
    passive_data
    |> cast(attrs, [:category, :value, :date])
    |> validate_required([:category, :value, :date])
  end
end
