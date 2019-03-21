defmodule HappierWeb.SelfEvaluationController do
  use HappierWeb, :controller

  alias Happier.Data
  alias Happier.Data.SelfEvaluation

  action_fallback HappierWeb.FallbackController

  def index(conn, _params) do
    selfevaluations = Data.list_selfevaluations()
    render(conn, "index.json", selfevaluations: selfevaluations)
  end

  def create(conn, %{"self_evaluation" => self_evaluation_params}) do
    with {:ok, %SelfEvaluation{} = self_evaluation} <- Data.create_self_evaluation(self_evaluation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", self_evaluation_path(conn, :show, self_evaluation))
      |> render("show.json", self_evaluation: self_evaluation)
    end
  end

  def show(conn, %{"id" => id}) do
    self_evaluation = Data.get_self_evaluation!(id)
    render(conn, "show.json", self_evaluation: self_evaluation)
  end

  def update(conn, %{"id" => id, "self_evaluation" => self_evaluation_params}) do
    self_evaluation = Data.get_self_evaluation!(id)

    with {:ok, %SelfEvaluation{} = self_evaluation} <- Data.update_self_evaluation(self_evaluation, self_evaluation_params) do
      render(conn, "show.json", self_evaluation: self_evaluation)
    end
  end

  def delete(conn, %{"id" => id}) do
    self_evaluation = Data.get_self_evaluation!(id)
    with {:ok, %SelfEvaluation{}} <- Data.delete_self_evaluation(self_evaluation) do
      send_resp(conn, :no_content, "")
    end
  end
end
