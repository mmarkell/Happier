defmodule Happier.Enums do
  def self_eval_categories() do
    [:mood, :energy, :social_satisfaction, :productivity]
    |> Enum.with_index()
    |> Map.new()
  end
end
