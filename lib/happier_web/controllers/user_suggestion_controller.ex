defmodule HappierWeb.UserSuggestionController do
  use HappierWeb, :controller

  alias Happier.Insights
  alias Happier.Insights.UserSuggestion

  action_fallback HappierWeb.FallbackController

  def index(conn, _params) do
    usersuggestions = Insights.list_usersuggestions()
    render(conn, "index.json", usersuggestions: usersuggestions)
  end

  def create(conn, %{"user_suggestion" => user_suggestion_params}) do
    with {:ok, %UserSuggestion{} = user_suggestion} <- Insights.create_user_suggestion(user_suggestion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_suggestion_path(conn, :show, user_suggestion))
      |> render("show.json", user_suggestion: user_suggestion)
    end
  end

  def show(conn, %{"id" => id}) do
    user_suggestion = Insights.get_user_suggestion!(id)
    render(conn, "show.json", user_suggestion: user_suggestion)
  end

  def update(conn, %{"id" => id, "user_suggestion" => user_suggestion_params}) do
    user_suggestion = Insights.get_user_suggestion!(id)

    with {:ok, %UserSuggestion{} = user_suggestion} <- Insights.update_user_suggestion(user_suggestion, user_suggestion_params) do
      render(conn, "show.json", user_suggestion: user_suggestion)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_suggestion = Insights.get_user_suggestion!(id)
    with {:ok, %UserSuggestion{}} <- Insights.delete_user_suggestion(user_suggestion) do
      send_resp(conn, :no_content, "")
    end
  end
end
