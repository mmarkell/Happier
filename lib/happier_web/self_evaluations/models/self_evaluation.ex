defmodule Happier.Data.SelfEvaluation do
  use Ecto.Schema
  import Ecto.Changeset


  schema "selfevaluations" do
    field :category, :integer
    field :date, :utc_datetime
    field :value, :map
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(self_evaluation, attrs) do
    self_evaluation
    |> cast(attrs, [:category, :value, :date])
    |> validate_required([:category, :value, :date])
  end
end
