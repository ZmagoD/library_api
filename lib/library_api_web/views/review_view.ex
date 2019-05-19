defmodule LibraryApiWeb.ReviewView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/reviews/:id"
  attributes [:username, :body, :created_at]

  def attributes(review, conn) do
    review
    |> Map.put(:username, review.user.username)
    |> Map.put(:created_at, review.inserted_at)
    |> super(conn)
  end

  has_one :book,
          serializer: LibraryApiWeb.BookView,
          identifiers: :when_included,
          links: [
            related: "/reviews/:id/book"
          ]


end