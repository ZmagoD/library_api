defmodule LibraryApi.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :ibsn, :string
      add :publish_date, :date

      add :author_id, references(:authors)

      timestamps()
    end
  end
end
