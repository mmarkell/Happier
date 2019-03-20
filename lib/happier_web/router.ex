defmodule HappierWeb.Router do
  use HappierWeb, :router

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug(Happier.Accounts.Pipeline)
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  # Maybe logged in routes
  scope "/api/v1", HappierWeb do
    pipe_through([:api])
    get("/login", SessionController, :new)
    post("/login", SessionController, :login)
    post("/logout", SessionController, :logout)
  end

  # Definitely logged in scope
  scope "/api/v1", HappierWeb do
    pipe_through([:api, :ensure_auth])
    resources("/users", UserController, except: [:new, :edit])
  end
end
