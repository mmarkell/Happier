defmodule Happier.DataTest do
  use Happier.DataCase

  alias Happier.Data

  describe "selfevaluations" do
    alias Happier.Data.SelfEvaluation

    @valid_attrs %{category: 42, date: "2010-04-17 14:00:00.000000Z", value: %{}}
    @update_attrs %{category: 43, date: "2011-05-18 15:01:01.000000Z", value: %{}}
    @invalid_attrs %{category: nil, date: nil, value: nil}

    def self_evaluation_fixture(attrs \\ %{}) do
      {:ok, self_evaluation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_self_evaluation()

      self_evaluation
    end

    test "list_selfevaluations/0 returns all selfevaluations" do
      self_evaluation = self_evaluation_fixture()
      assert Data.list_selfevaluations() == [self_evaluation]
    end

    test "get_self_evaluation!/1 returns the self_evaluation with given id" do
      self_evaluation = self_evaluation_fixture()
      assert Data.get_self_evaluation!(self_evaluation.id) == self_evaluation
    end

    test "create_self_evaluation/1 with valid data creates a self_evaluation" do
      assert {:ok, %SelfEvaluation{} = self_evaluation} = Data.create_self_evaluation(@valid_attrs)
      assert self_evaluation.category == 42
      assert self_evaluation.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert self_evaluation.value == %{}
    end

    test "create_self_evaluation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_self_evaluation(@invalid_attrs)
    end

    test "update_self_evaluation/2 with valid data updates the self_evaluation" do
      self_evaluation = self_evaluation_fixture()
      assert {:ok, self_evaluation} = Data.update_self_evaluation(self_evaluation, @update_attrs)
      assert %SelfEvaluation{} = self_evaluation
      assert self_evaluation.category == 43
      assert self_evaluation.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert self_evaluation.value == %{}
    end

    test "update_self_evaluation/2 with invalid data returns error changeset" do
      self_evaluation = self_evaluation_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_self_evaluation(self_evaluation, @invalid_attrs)
      assert self_evaluation == Data.get_self_evaluation!(self_evaluation.id)
    end

    test "delete_self_evaluation/1 deletes the self_evaluation" do
      self_evaluation = self_evaluation_fixture()
      assert {:ok, %SelfEvaluation{}} = Data.delete_self_evaluation(self_evaluation)
      assert_raise Ecto.NoResultsError, fn -> Data.get_self_evaluation!(self_evaluation.id) end
    end

    test "change_self_evaluation/1 returns a self_evaluation changeset" do
      self_evaluation = self_evaluation_fixture()
      assert %Ecto.Changeset{} = Data.change_self_evaluation(self_evaluation)
    end
  end

  describe "passivedata" do
    alias Happier.Data.PassiveData

    @valid_attrs %{category: 42, date: "2010-04-17 14:00:00.000000Z", value: %{}}
    @update_attrs %{category: 43, date: "2011-05-18 15:01:01.000000Z", value: %{}}
    @invalid_attrs %{category: nil, date: nil, value: nil}

    def passive_data_fixture(attrs \\ %{}) do
      {:ok, passive_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_passive_data()

      passive_data
    end

    test "list_passivedata/0 returns all passivedata" do
      passive_data = passive_data_fixture()
      assert Data.list_passivedata() == [passive_data]
    end

    test "get_passive_data!/1 returns the passive_data with given id" do
      passive_data = passive_data_fixture()
      assert Data.get_passive_data!(passive_data.id) == passive_data
    end

    test "create_passive_data/1 with valid data creates a passive_data" do
      assert {:ok, %PassiveData{} = passive_data} = Data.create_passive_data(@valid_attrs)
      assert passive_data.category == 42
      assert passive_data.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert passive_data.value == %{}
    end

    test "create_passive_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_passive_data(@invalid_attrs)
    end

    test "update_passive_data/2 with valid data updates the passive_data" do
      passive_data = passive_data_fixture()
      assert {:ok, passive_data} = Data.update_passive_data(passive_data, @update_attrs)
      assert %PassiveData{} = passive_data
      assert passive_data.category == 43
      assert passive_data.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert passive_data.value == %{}
    end

    test "update_passive_data/2 with invalid data returns error changeset" do
      passive_data = passive_data_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_passive_data(passive_data, @invalid_attrs)
      assert passive_data == Data.get_passive_data!(passive_data.id)
    end

    test "delete_passive_data/1 deletes the passive_data" do
      passive_data = passive_data_fixture()
      assert {:ok, %PassiveData{}} = Data.delete_passive_data(passive_data)
      assert_raise Ecto.NoResultsError, fn -> Data.get_passive_data!(passive_data.id) end
    end

    test "change_passive_data/1 returns a passive_data changeset" do
      passive_data = passive_data_fixture()
      assert %Ecto.Changeset{} = Data.change_passive_data(passive_data)
    end
  end

  describe "journaldata" do
    alias Happier.Data.JournalData

    @valid_attrs %{analysis: %{}, date: "2010-04-17 14:00:00.000000Z", entry: "some entry"}
    @update_attrs %{analysis: %{}, date: "2011-05-18 15:01:01.000000Z", entry: "some updated entry"}
    @invalid_attrs %{analysis: nil, date: nil, entry: nil}

    def journal_data_fixture(attrs \\ %{}) do
      {:ok, journal_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_journal_data()

      journal_data
    end

    test "list_journaldata/0 returns all journaldata" do
      journal_data = journal_data_fixture()
      assert Data.list_journaldata() == [journal_data]
    end

    test "get_journal_data!/1 returns the journal_data with given id" do
      journal_data = journal_data_fixture()
      assert Data.get_journal_data!(journal_data.id) == journal_data
    end

    test "create_journal_data/1 with valid data creates a journal_data" do
      assert {:ok, %JournalData{} = journal_data} = Data.create_journal_data(@valid_attrs)
      assert journal_data.analysis == %{}
      assert journal_data.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert journal_data.entry == "some entry"
    end

    test "create_journal_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_journal_data(@invalid_attrs)
    end

    test "update_journal_data/2 with valid data updates the journal_data" do
      journal_data = journal_data_fixture()
      assert {:ok, journal_data} = Data.update_journal_data(journal_data, @update_attrs)
      assert %JournalData{} = journal_data
      assert journal_data.analysis == %{}
      assert journal_data.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert journal_data.entry == "some updated entry"
    end

    test "update_journal_data/2 with invalid data returns error changeset" do
      journal_data = journal_data_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_journal_data(journal_data, @invalid_attrs)
      assert journal_data == Data.get_journal_data!(journal_data.id)
    end

    test "delete_journal_data/1 deletes the journal_data" do
      journal_data = journal_data_fixture()
      assert {:ok, %JournalData{}} = Data.delete_journal_data(journal_data)
      assert_raise Ecto.NoResultsError, fn -> Data.get_journal_data!(journal_data.id) end
    end

    test "change_journal_data/1 returns a journal_data changeset" do
      journal_data = journal_data_fixture()
      assert %Ecto.Changeset{} = Data.change_journal_data(journal_data)
    end
  end
end
