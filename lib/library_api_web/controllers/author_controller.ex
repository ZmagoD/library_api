defmodule LibraryApiWeb.AuthorController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.Author

  plug :authenticate_user when action in [:create, :update, :delete]

  def index(conn, %{"filter" => %{ "query" => search_term }}) do
    authors = Library.search_authors(search_term)
    render(conn, "index.json", data: authors)
  end

  def index(conn, _params) do
    authors = Library.list_authors()
    render(conn, "index.json", data: authors)
  end

  def create(conn, %{:current_user => user, "data" => data = %{ "type" => "authors", "attributes" => author_params }}) do
    data = data
      |> JaSerializer.Params.to_attributes()
      |> Map.put("user_id", user.id)

    case Library.create_author(data) do
      {:ok, %Author{} = author} ->
        conn
        |> put_status(:created)
        |> Plug.Conn.put_resp_header("location", Routes.author_path(conn, :show, author))
        |> render("show.json", data: author)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LibraryApiWeb.ErrorView, "400.json", changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Library.get_author!(id)
    render(conn, "show.json", data: author)
  end

  def author_for_book(conn, %{"book_id" => book_id}) do
    author = Library.get_author_for_book!(book_id)
    render(conn, "show.json", data: author)
  end

  def update(conn, %{:current_user => current_user, "id" => id, "data" => data = %{ "type" => "authors", "attributes" => author_params }}) do
    data = JaSerializer.Params.to_attributes(data)
    author = Library.get_author!(id)

    cond do
      author.user_id == current_user.id ->
        case Library.update_author(author, author_params) do
          {:ok, %Author{} = author} ->
            conn
            |> render(conn, "show.json", data: author)
          {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(LibraryApiWeb.ErrorView, "400.json", changeset)
        end
      true ->
        access_error(conn)
    end
  end

  def delete(conn, %{:current_user => current_user, "id" => id}) do
    author = Library.get_author!(id)

    cond do
      author.user_id == current_user.id ->
        with {:ok, %Author{}} <- Library.delete_author(author) do
          conn
          |> send_resp(:no_content, "")
        end
      true ->
        access_error(conn)
    end
  end
end