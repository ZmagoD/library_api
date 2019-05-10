defmodule LibraryApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review

  schema "books" do
    field :title, :string
    field :ibsn, :string
    field :publish_date, :date

    belongs_to :author, Author
    has_many :reviews, Review
    timestamps()
  end

  @required_fields [:title, :ibsn, :publish_date, :author_id]

  def changeset(%Book{} = model, attrs) do
    model
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end