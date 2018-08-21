defmodule PinBinWeb.AuthController do
  use PinBinWeb, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias PinBin.User

  @token_type "Bearer"

  def show(conn, params) do
    case PinBinWeb.Auth.api_login_by_email_and_pass(conn, params) do
      {:ok, conn} ->
        jwt = Guardian.Plug.current_token(conn)
        {:ok, claims} = Guardian.Plug.claims(conn)
        exp = Map.get(claims, "exp")

        conn
        |> put_resp_header("authorization", @token_type <> " #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> render("login.json", jwt: jwt, exp: exp, token_type: @token_type)
      {:error, reason, conn} ->
        conn
        |> render(PinBinWeb.ErrorView, "error.json", reason: reason)
    end
  end
end
