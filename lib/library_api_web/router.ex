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
    post "/users", UserController, :create
    post "/session", SessionController, :create
    get "/users/me", UserController, :show_current

    resources "/authors", AuthorController, except: [:new, :edit]
    resources "/books", BookController, except: [:new, :edit]
    resources "/reviews", ReviewController, except: [:new, :edit]

    get "/authors/:author_id/books", BookController, :books_for_author
    get "/books/:book_id/author", AuthorController, :author_for_book
    get "/books/:book_id/reviews", ReviewController, :reviews_for_book
    get "/reviews/:review_id/book", BookController, :book_for_review
  end
end
