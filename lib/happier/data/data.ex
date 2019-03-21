defmodule Happier.Data do
  @moduledoc """
  The Data context.
  """

  import Ecto.Query, warn: false
  alias Happier.Repo

  alias Happier.Data.SelfEvaluation

  @doc """
  Returns the list of selfevaluations.

  ## Examples

      iex> list_selfevaluations()
      [%SelfEvaluation{}, ...]

  """
  def list_selfevaluations do
    Repo.all(SelfEvaluation)
  end

  @doc """
  Gets a single self_evaluation.

  Raises `Ecto.NoResultsError` if the Self evaluation does not exist.

  ## Examples

      iex> get_self_evaluation!(123)
      %SelfEvaluation{}

      iex> get_self_evaluation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_self_evaluation!(id), do: Repo.get!(SelfEvaluation, id)

  @doc """
  Creates a self_evaluation.

  ## Examples

      iex> create_self_evaluation(%{field: value})
      {:ok, %SelfEvaluation{}}

      iex> create_self_evaluation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_self_evaluation(attrs \\ %{}) do
    %SelfEvaluation{}
    |> SelfEvaluation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a self_evaluation.

  ## Examples

      iex> update_self_evaluation(self_evaluation, %{field: new_value})
      {:ok, %SelfEvaluation{}}

      iex> update_self_evaluation(self_evaluation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_self_evaluation(%SelfEvaluation{} = self_evaluation, attrs) do
    self_evaluation
    |> SelfEvaluation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SelfEvaluation.

  ## Examples

      iex> delete_self_evaluation(self_evaluation)
      {:ok, %SelfEvaluation{}}

      iex> delete_self_evaluation(self_evaluation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_self_evaluation(%SelfEvaluation{} = self_evaluation) do
    Repo.delete(self_evaluation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking self_evaluation changes.

  ## Examples

      iex> change_self_evaluation(self_evaluation)
      %Ecto.Changeset{source: %SelfEvaluation{}}

  """
  def change_self_evaluation(%SelfEvaluation{} = self_evaluation) do
    SelfEvaluation.changeset(self_evaluation, %{})
  end
end
