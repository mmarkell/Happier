defmodule HappierWeb.Router do
  use HappierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HappierWeb do
    pipe_through :api
  end
end
