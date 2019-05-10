defmodule LibraryApi.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review

  schema "reviews" do
    field :body, :string
    field :user, :string

    belongs_to :book, Book

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [:user, :body, :book_id])
    |> validate_required([:user, :body, :book_id])
  end
end
