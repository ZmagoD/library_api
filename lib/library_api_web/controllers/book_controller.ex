defmodule LibraryApiWeb.BookController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.Book

  def index(conn, %{"filter" => %{ "query" => search_term }}) do
    books = Library.search_books(search_term)
    render(conn, "index.json", data: books)
  end

  def index(conn, _params) do
    books = Library.list_books()
    render(conn, "index.json", data: books)
  end

  def books_for_author(conn, %{"author_id" => author_id}) do
    books = Library.list_books_for_author(author_id)
    render(conn, "index.json", data: books)
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    render(conn, "show.json", data: book)
  end

  def book_for_review(conn, %{"review_id" => review_id}) do
    book = Library.get_book_by_review!(review_id)

    render(conn, "show.json", data: book)
  end

  def create(conn, %{"data" => data = %{ "type" => "books", "attributes" => _book_params }}) do
    data = JaSerializer.Params.to_attributes data
    data = Map.put data, "publish_date", Date.from_iso8601!(data["publish_date"])

    with {:ok, %Book{} = book} <- Library.create_book(data) do
      conn
      |> put_status(:created)
      |> Plug.Conn.put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", data: book)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{ "type" => "books", "attributes" => _book_params }}) do
    book = Library.get_book!(id)
    data = JaSerializer.Params.to_attributes data

    if data["publish_date"] do
      data = Map.put data, "publish_date", Date.from_iso8601!(data["publish_date"])
    end

    with {:ok, %Book{} = book} <- Library.update_book(book, data) do
      conn
      |> render("show.json", data: book)
     end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)

    with {:ok, %Book{} = book} <- Library.delete_book(book) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end