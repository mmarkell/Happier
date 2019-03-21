defmodule HappierWeb.Router do
  use HappierWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :user_authentication do
    plug(Happier.Accounts.Pipeline)
  end

  # unauthenticated routes
  scope "/api/v1", HappierWeb do
    pipe_through([:api])
    post("/login", SessionController, :login)
    post("/logout", SessionController, :logout)
  end

  # authenticated routes
  scope "/api/v1", HappierWeb do
    pipe_through([:api, :user_authentication])
    resources("/users", UserController, except: [:new, :edit, :index])
    resources("/selfevaluations", SelfEvaluationController, except: [:new, :edit])
    resources("/passivedata", PassiveDataController, except: [:new, :edit])
  end
end
