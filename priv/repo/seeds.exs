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

Happier.Accounts.create_user(%{
  username: "ilovechicken444",
  email: "michaelmarkell1@gmail.com",
  password: "mypassword",
  tier: 1,
  phone_number: "3022290419",
  date_created: DateTime.utc_now()
})

Happier.Repo.insert!(%Happier.Data.JournalData{
  user_id: 1,
  entry: "",
  analysis: %{},
  date: DateTime.utc_now()
})

Happier.Repo.insert!(%Happier.Data.PassiveData{
  user_id: 1,
  category: 1,
  value: %{},
  date: DateTime.utc_now()
})

Happier.Repo.insert!(%Happier.Data.SelfEvaluation{
  user_id: 1,
  category: 1,
  value: %{},
  date: DateTime.utc_now()
})

Happier.Repo.insert!(%Happier.Insights.UserSuggestion{
  user_id: 1,
  category: 1,
  suggestion: 1,
  date_created: DateTime.utc_now()
})
