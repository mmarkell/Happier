defmodule Happier.InsightsTest do
  use Happier.DataCase

  alias Happier.Insights

  describe "usersuggestions" do
    alias Happier.Insights.UserSuggestion

    @valid_attrs %{category: 42, date_created: "2010-04-17 14:00:00.000000Z", suggestion: 42}
    @update_attrs %{category: 43, date_created: "2011-05-18 15:01:01.000000Z", suggestion: 43}
    @invalid_attrs %{category: nil, date_created: nil, suggestion: nil}

    def user_suggestion_fixture(attrs \\ %{}) do
      {:ok, user_suggestion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Insights.create_user_suggestion()

      user_suggestion
    end

    test "list_usersuggestions/0 returns all usersuggestions" do
      user_suggestion = user_suggestion_fixture()
      assert Insights.list_usersuggestions() == [user_suggestion]
    end

    test "get_user_suggestion!/1 returns the user_suggestion with given id" do
      user_suggestion = user_suggestion_fixture()
      assert Insights.get_user_suggestion!(user_suggestion.id) == user_suggestion
    end

    test "create_user_suggestion/1 with valid data creates a user_suggestion" do
      assert {:ok, %UserSuggestion{} = user_suggestion} = Insights.create_user_suggestion(@valid_attrs)
      assert user_suggestion.category == 42
      assert user_suggestion.date_created == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert user_suggestion.suggestion == 42
    end

    test "create_user_suggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Insights.create_user_suggestion(@invalid_attrs)
    end

    test "update_user_suggestion/2 with valid data updates the user_suggestion" do
      user_suggestion = user_suggestion_fixture()
      assert {:ok, user_suggestion} = Insights.update_user_suggestion(user_suggestion, @update_attrs)
      assert %UserSuggestion{} = user_suggestion
      assert user_suggestion.category == 43
      assert user_suggestion.date_created == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert user_suggestion.suggestion == 43
    end

    test "update_user_suggestion/2 with invalid data returns error changeset" do
      user_suggestion = user_suggestion_fixture()
      assert {:error, %Ecto.Changeset{}} = Insights.update_user_suggestion(user_suggestion, @invalid_attrs)
      assert user_suggestion == Insights.get_user_suggestion!(user_suggestion.id)
    end

    test "delete_user_suggestion/1 deletes the user_suggestion" do
      user_suggestion = user_suggestion_fixture()
      assert {:ok, %UserSuggestion{}} = Insights.delete_user_suggestion(user_suggestion)
      assert_raise Ecto.NoResultsError, fn -> Insights.get_user_suggestion!(user_suggestion.id) end
    end

    test "change_user_suggestion/1 returns a user_suggestion changeset" do
      user_suggestion = user_suggestion_fixture()
      assert %Ecto.Changeset{} = Insights.change_user_suggestion(user_suggestion)
    end
  end
end
