defmodule LibraryApi.Repo.Migrations.AddUserIdToAuthorsBooksAndReviews do
  use Ecto.Migration

  def up do
    alter table("authors") do
      add :user_id, references(:users, on_delete: :nilify_all)
    end

    alter table("books") do
      add :user_id, references(:users, on_delete: :nilify_all)
    end

    alter table("reviews") do
      add :user_id, references(:users, on_delete: :nilify_all)
      remove :user
    end
  end

  def down do
    alter table("authors") do
      remove :user_id
    end

    alter table("books") do
      remove :user_id
    end

    alter table("reviews") do
      remove :user_id
      add :user, :string
    end
  end
end
