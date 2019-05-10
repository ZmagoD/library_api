defmodule LibraryApiWeb.ReviewView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/reviews/:id"
  attributes [:user, :body, :created_at]

  def attributes(reivew, conn) do
    reivew
    |> Map.put(:created_at, reivew.inserted_at)
    |> super(conn)
  end

  has_one :book,
          serializer: LibraryApiWeb.BookView,
          identifiers: :when_included,
          links: [
            related: "/reviews/:id/book"
          ]

end