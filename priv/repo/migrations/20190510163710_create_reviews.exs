defmodule LibraryApi.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :user, :string
      add :body, :string
      add :book_id, references(:books, on_delete: :delete_all)

      timestamps()
    end

    create index(:reviews, [:book_id])
  end
end
