defmodule LibraryApiWeb.UserController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.User

  plug :authenticate_user when action in [:show_current]

  def create(conn, %{ "data" => data = %{ "type" => "users", "attributes" => _user_params } }) do
    attrs = JaSerializer.Params.to_attributes(data)

    case Library.create_user(attrs) do
      { :ok, %User{} = user } ->
        conn
        |> put_status(:created)
        |> render("show.json", data: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LibraryApiWeb.ErrorView, "400.json", changeset)
    end
  end

  def show_current(conn, %{ current_user: user }) do
    conn
    |> render("show.json", data: user)
  end
end