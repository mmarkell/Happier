defmodule HappierWeb.UserSuggestionView do
  use HappierWeb, :view
  alias HappierWeb.UserSuggestionView

  def render("index.json", %{usersuggestions: usersuggestions}) do
    %{data: render_many(usersuggestions, UserSuggestionView, "user_suggestion.json")}
  end

  def render("show.json", %{user_suggestion: user_suggestion}) do
    %{data: render_one(user_suggestion, UserSuggestionView, "user_suggestion.json")}
  end

  def render("user_suggestion.json", %{user_suggestion: user_suggestion}) do
    %{id: user_suggestion.id,
      category: user_suggestion.category,
      suggestion: user_suggestion.suggestion,
      date_created: user_suggestion.date_created}
  end
end
