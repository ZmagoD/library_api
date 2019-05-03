defmodule LibraryApi.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :first, :string
      add :last, :string

      timestamps()
    end
  end
end
