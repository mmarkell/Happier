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

  alias Happier.Data.PassiveData

  @doc """
  Returns the list of passivedata.

  ## Examples

      iex> list_passivedata()
      [%PassiveData{}, ...]

  """
  def list_passivedata do
    Repo.all(PassiveData)
  end

  @doc """
  Gets a single passive_data.

  Raises `Ecto.NoResultsError` if the Passive data does not exist.

  ## Examples

      iex> get_passive_data!(123)
      %PassiveData{}

      iex> get_passive_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passive_data!(id), do: Repo.get!(PassiveData, id)

  @doc """
  Creates a passive_data.

  ## Examples

      iex> create_passive_data(%{field: value})
      {:ok, %PassiveData{}}

      iex> create_passive_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passive_data(attrs \\ %{}) do
    %PassiveData{}
    |> PassiveData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a passive_data.

  ## Examples

      iex> update_passive_data(passive_data, %{field: new_value})
      {:ok, %PassiveData{}}

      iex> update_passive_data(passive_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passive_data(%PassiveData{} = passive_data, attrs) do
    passive_data
    |> PassiveData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PassiveData.

  ## Examples

      iex> delete_passive_data(passive_data)
      {:ok, %PassiveData{}}

      iex> delete_passive_data(passive_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_passive_data(%PassiveData{} = passive_data) do
    Repo.delete(passive_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking passive_data changes.

  ## Examples

      iex> change_passive_data(passive_data)
      %Ecto.Changeset{source: %PassiveData{}}

  """
  def change_passive_data(%PassiveData{} = passive_data) do
    PassiveData.changeset(passive_data, %{})
  end

  alias Happier.Data.JournalData

  @doc """
  Returns the list of journaldata.

  ## Examples

      iex> list_journaldata()
      [%JournalData{}, ...]

  """
  def list_journaldata do
    Repo.all(JournalData)
  end

  @doc """
  Gets a single journal_data.

  Raises `Ecto.NoResultsError` if the Journal data does not exist.

  ## Examples

      iex> get_journal_data!(123)
      %JournalData{}

      iex> get_journal_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_journal_data!(id), do: Repo.get!(JournalData, id)

  @doc """
  Creates a journal_data.

  ## Examples

      iex> create_journal_data(%{field: value})
      {:ok, %JournalData{}}

      iex> create_journal_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_journal_data(attrs \\ %{}) do
    %JournalData{}
    |> JournalData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a journal_data.

  ## Examples

      iex> update_journal_data(journal_data, %{field: new_value})
      {:ok, %JournalData{}}

      iex> update_journal_data(journal_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_journal_data(%JournalData{} = journal_data, attrs) do
    journal_data
    |> JournalData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a JournalData.

  ## Examples

      iex> delete_journal_data(journal_data)
      {:ok, %JournalData{}}

      iex> delete_journal_data(journal_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_journal_data(%JournalData{} = journal_data) do
    Repo.delete(journal_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking journal_data changes.

  ## Examples

      iex> change_journal_data(journal_data)
      %Ecto.Changeset{source: %JournalData{}}

  """
  def change_journal_data(%JournalData{} = journal_data) do
    JournalData.changeset(journal_data, %{})
  end
end
