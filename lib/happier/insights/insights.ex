defmodule Happier.Insights do
  @moduledoc """
  The Insights context.
  """

  import Ecto.Query, warn: false
  alias Happier.Repo

  alias Happier.Insights.UserSuggestion

  @doc """
  Returns the list of usersuggestions.

  ## Examples

      iex> list_usersuggestions()
      [%UserSuggestion{}, ...]

  """
  def list_usersuggestions do
    Repo.all(UserSuggestion)
  end

  @doc """
  Gets a single user_suggestion.

  Raises `Ecto.NoResultsError` if the User suggestion does not exist.

  ## Examples

      iex> get_user_suggestion!(123)
      %UserSuggestion{}

      iex> get_user_suggestion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_suggestion!(id), do: Repo.get!(UserSuggestion, id)

  @doc """
  Creates a user_suggestion.

  ## Examples

      iex> create_user_suggestion(%{field: value})
      {:ok, %UserSuggestion{}}

      iex> create_user_suggestion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_suggestion(attrs \\ %{}) do
    %UserSuggestion{}
    |> UserSuggestion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_suggestion.

  ## Examples

      iex> update_user_suggestion(user_suggestion, %{field: new_value})
      {:ok, %UserSuggestion{}}

      iex> update_user_suggestion(user_suggestion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_suggestion(%UserSuggestion{} = user_suggestion, attrs) do
    user_suggestion
    |> UserSuggestion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserSuggestion.

  ## Examples

      iex> delete_user_suggestion(user_suggestion)
      {:ok, %UserSuggestion{}}

      iex> delete_user_suggestion(user_suggestion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_suggestion(%UserSuggestion{} = user_suggestion) do
    Repo.delete(user_suggestion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_suggestion changes.

  ## Examples

      iex> change_user_suggestion(user_suggestion)
      %Ecto.Changeset{source: %UserSuggestion{}}

  """
  def change_user_suggestion(%UserSuggestion{} = user_suggestion) do
    UserSuggestion.changeset(user_suggestion, %{})
  end
end
