defmodule LibraryApiWeb.AuthorView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/authors/:id"
  attributes [:first, :last]

  has_many :books,
           serializer: LibraryApiWeb.BookView,
           identifiers: :when_included,
           links: [
             related: "/authors/:id/books"
           ]
end