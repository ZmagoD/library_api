defmodule LibraryApi.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review
  alias LibraryApi.Library.User

  schema "reviews" do
    field :body, :string

    belongs_to :book, Book
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [:body, :book_id, :user_id])
    |> validate_required([:body, :book_id, :user_id])
  end
end
