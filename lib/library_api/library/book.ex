defmodule LibraryApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review
  alias LibraryApi.Library.User

  schema "books" do
    field :title, :string
    field :ibsn, :string
    field :publish_date, :date

    belongs_to :author, Author
    has_many :reviews, Review
    belongs_to :user, User
    timestamps()
  end

  @required_fields [:title, :ibsn, :publish_date, :author_id, :user_id]

  def changeset(%Book{} = model, attrs) do
    model
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end