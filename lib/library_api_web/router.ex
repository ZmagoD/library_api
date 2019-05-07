defmodule LibraryApiWeb.Router do
  use LibraryApiWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", LibraryApiWeb do
    pipe_through :api
    get "/", StatusController, :index
    resources "/authors", AuthorController, except: [:new, :edit]
    resources "/books", BookController, except: [:new, :edit]

    get "/authors/:author_id/books", BookController, :books_for_author
    get "/books/:book_id/author", AuthorController, :author_for_book
  end
end
