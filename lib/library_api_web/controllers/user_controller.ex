defmodule LibraryApiWeb.UserController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.User

  def create(conn, %{ "data" => data = %{ "type" => "users", "attributes" => _user_params } }) do
    attrs = JaSerializer.Params.to_attributes(data)

    case Library.create_user(attrs) do
      { :ok, %User{} = user } ->
        conn
        |> put_status(:created)
        |> render("show.json", data: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(LibraryApiWeb.ErrorView, "400.json", changeset)
    end
  end
end