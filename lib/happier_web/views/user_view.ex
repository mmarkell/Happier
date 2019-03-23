defmodule HappierWeb.UserView do
  use HappierWeb, :view
  alias HappierWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      phone_number: user.phone_number,
      email: user.email,
      tier: user.tier,
      date_created: user.date_created
    }
  end
end
