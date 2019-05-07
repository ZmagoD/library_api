defmodule LibraryApiWeb.BookView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/books/:id"
  attributes [:title, :ibsn, :publish_date]

  has_one :author,
          serializer: LibraryApiWeb.AuthorView,
          identifiers: :when_included,
          links: [
            related: "/books/:id/author"
          ]
end