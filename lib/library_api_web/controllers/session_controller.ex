defmodule LibraryApiWeb.SessionController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.User

  def create(conn, %{ "email" => email, "password" => password}) do
    try do
      user = Library.get_user_by_email!(email)

      if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
        conn
        |> render("token.json", user)
      else
        conn
        |> put_status(:unauthorized)
        |> render(LibraryApiWeb.ErrorView, "401.json", %{detail: "Error loggin in user with that email and password"})
      end
    rescue
      _e ->
        Comeonin.Bcrypt.dummy_checkpw()

        conn
        |> put_status(:unauthorized)
        |> render(LibraryApiWeb.ErrorView, "401.json", %{detail: "Error loggin in user with that email and password"})
    end
  end
end