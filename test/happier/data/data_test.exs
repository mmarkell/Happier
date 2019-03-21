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
end
