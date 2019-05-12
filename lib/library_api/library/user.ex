defmodule LibraryApi.Library.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def hash_password(changeset) do
    hash = Bcrypt.hashpwsalt(get_field(changeset, :password))

    put_change(changeset, :password_hash, hash)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation])
    |> validate_required([:email, :username, :password, :password_confirmation])
    |> unsafe_validate_unique([:email], LibraryApi.Repo)
    |> unsafe_validate_unique([:username], LibraryApi.Repo)
    |> validate_confirmation(:password)
    |> hash_password()
  end
end
