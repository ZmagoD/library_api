defmodule LibraryApi.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Author

  schema "authors" do
    field :first, :string
    field :last, :string

    timestamps()
  end

  def changeset(%Author{} = model, attrs) do
    model
    |> cast(attrs, [:first, :last])
    |> validate_required([:first, :last])
  end
end