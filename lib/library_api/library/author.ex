defmodule LibraryApi.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.User

  schema "authors" do
    field :first, :string
    field :last, :string

    has_many :books, Book
    belongs_to :user, User
    timestamps()
  end

  def changeset(%Author{} = model, attrs) do
    model
    |> cast(attrs, [:first, :last, :user_id])
    |> validate_required([:first, :last, :user_id])
  end
end