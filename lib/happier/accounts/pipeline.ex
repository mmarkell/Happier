defmodule Happier.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :auth_me,
    error_handler: Happier.Accounts.ErrorHandler,
    module: Happier.Accounts.Guardian

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
