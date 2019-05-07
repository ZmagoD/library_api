defmodule LibraryApi.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book

  schema "authors" do
    field :first, :string
    field :last, :string

    has_many :books, Book
    timestamps()
  end

  def changeset(%Author{} = model, attrs) do
    model
    |> cast(attrs, [:first, :last])
    |> validate_required([:first, :last])
  end
end