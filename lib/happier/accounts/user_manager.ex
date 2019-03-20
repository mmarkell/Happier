defmodule Happier.Accounts.UserManager do
  alias Bcrypt
  alias Happier.Accounts.User
  import Ecto.Query

  def authenticate_user(username, plain_text_password) do
    IO.puts("authenticating")
    query = from(u in User, where: u.username == ^username)

    case Happier.Repo.one(query) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
