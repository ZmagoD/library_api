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
  end
end
