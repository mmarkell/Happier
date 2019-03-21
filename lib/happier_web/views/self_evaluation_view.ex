defmodule HappierWeb.SelfEvaluationView do
  use HappierWeb, :view
  alias HappierWeb.SelfEvaluationView

  def render("index.json", %{selfevaluations: selfevaluations}) do
    %{data: render_many(selfevaluations, SelfEvaluationView, "self_evaluation.json")}
  end

  def render("show.json", %{self_evaluation: self_evaluation}) do
    %{data: render_one(self_evaluation, SelfEvaluationView, "self_evaluation.json")}
  end

  def render("self_evaluation.json", %{self_evaluation: self_evaluation}) do
    %{id: self_evaluation.id,
      category: self_evaluation.category,
      value: self_evaluation.value,
      date: self_evaluation.date}
  end
end
