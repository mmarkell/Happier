defmodule Happier.Insights.UserSuggestion do
  use Ecto.Schema
  import Ecto.Changeset


  schema "usersuggestions" do
    field :category, :integer
    field :date_created, :utc_datetime
    field :suggestion, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_suggestion, attrs) do
    user_suggestion
    |> cast(attrs, [:category, :suggestion, :date_created])
    |> validate_required([:category, :suggestion, :date_created])
  end
end
