defmodule Happier.AccountsTest do
  use Happier.DataCase

  alias Happier.Accounts

  describe "users" do
    alias Happier.Accounts.User

    @valid_attrs %{
      email: "some email",
      password: "some password",
      phone_number: "some phone_number",
      registered_date: "2010-04-17 14:00:00.000000Z",
      tier: 42,
      username: "some username"
    }
    @update_attrs %{
      email: "some updated email",
      password: "some updated password",
      phone_number: "some updated phone_number",
      registered_date: "2011-05-18 15:01:01.000000Z",
      tier: 43,
      username: "some updated username"
    }
    @invalid_attrs %{
      email: nil,
      password: nil,
      phone_number: nil,
      registered_date: nil,
      tier: nil,
      username: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      [stored_user] = Accounts.list_users()
      assert user.email == stored_user.email
      assert stored_user.password == nil
      assert user.phone_number == stored_user.phone_number
      assert user.tier == stored_user.tier
      assert user.username == stored_user.username
      assert user.registered_date == stored_user.registered_date
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      stored_user = Accounts.get_user!(user.id)
      assert user.email == stored_user.email
      assert stored_user.password == nil
      assert user.phone_number == stored_user.phone_number
      assert user.tier == stored_user.tier
      assert user.username == stored_user.username
      assert user.registered_date == stored_user.registered_date
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash != "some password"
      assert user.phone_number == "some phone_number"

      assert user.registered_date ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")

      assert user.tier == 42
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.phone_number == "some updated phone_number"

      assert user.registered_date ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")

      assert user.tier == 43
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      stored_user = Accounts.get_user!(user.id)
      assert user.email == stored_user.email
      assert stored_user.password == nil
      assert user.phone_number == stored_user.phone_number
      assert user.tier == stored_user.tier
      assert user.username == stored_user.username
      assert user.registered_date == stored_user.registered_date
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
