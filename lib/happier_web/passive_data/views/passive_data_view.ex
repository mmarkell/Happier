defmodule HappierWeb.PassiveDataView do
  use HappierWeb, :view
  alias HappierWeb.PassiveDataView

  def render("index.json", %{passivedata: passivedata}) do
    %{data: render_many(passivedata, PassiveDataView, "passive_data.json")}
  end

  def render("show.json", %{passive_data: passive_data}) do
    %{data: render_one(passive_data, PassiveDataView, "passive_data.json")}
  end

  def render("passive_data.json", %{passive_data: passive_data}) do
    %{id: passive_data.id,
      category: passive_data.category,
      value: passive_data.value,
      date: passive_data.date}
  end
end
