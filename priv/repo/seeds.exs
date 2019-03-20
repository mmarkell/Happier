# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Happier.Repo.insert!(%Happier.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Happier.Repo.insert!(%Happier.Accounts.User{
  username: "ilovechicken444",
  password: "mypassword",
  tier: 1,
  phone_number: "3022290419"
})
