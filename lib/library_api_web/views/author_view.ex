defmodule LibraryApiWeb.AuthorView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/authors/:id"
  attributes [:username, :first, :last]

  def attributes(model, conn) do
    model
    |> Map.put(:username, model.user.username)
    |> super(conn)
  end

  has_many :books,
           serializer: LibraryApiWeb.BookView,
           identifiers: :when_included,
           links: [
             related: "/authors/:id/books"
           ]
end