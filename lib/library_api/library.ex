defmodule LibraryApi.Library do
  alias LibraryApi.Repo
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  import Ecto.Query

  def list_authors, do: Repo.all(Author)

  def search_authors(search_term) do
    search_term = String.downcase(search_term)

    Author
    |> where([a], like(fragment("lower(?)", a.first), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.last), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def get_author!(id), do: Repo.get!(Author, id)

  def get_author_for_book!(book_id) do
    book = get_book!(book_id)
    book = Repo.preload(book, :author)
    book.author
  end

  def create_author(attrs \\ %{}) do
   %Author{}
   |> Author.changeset(attrs)
   |> Repo.insert
  end

  def update_author(%Author{} = model, attrs \\ %{}) do
    model
    |> Author.changeset(attrs)
    |> Repo.update
  end

  def delete_author(%Author{} = model), do: Repo.delete(model)

  # Book

  def list_books, do: Repo.all(Book)

  def list_books_for_author(author_id) do
    Book
    |> where([b], b.author_id == ^author_id)
    |> Repo.all()
  end

  def search_books(search_term) do
    search_term = String.downcase(search_term)

    Book
    |> where([a], like(fragment("lower(?)", a.title), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.ibsn), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def get_book!(id), do: Repo.get!(Book, id)

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert
  end

  def update_book(%Book{} = model, attrs \\ %{}) do
    model
    |> Book.changeset(attrs)
    |> Repo.update
  end

  def delete_book(%Book{} = model), do: Repo.delete(model)
end