defmodule LibraryApi.Library do
  alias LibraryApi.Repo
  alias LibraryApi.Library.Author

  def list_authors, do: Repo.all(Author)
  def get_author!(id), do: Repo.get!(Author, id)

  def create_author(attrs \\ %{}) do
   %Author{}
   |> Author.changeset(attrs)
   |> Repo.insert
  end

  def update_author(%Author{} = model, attrs \\ %{}) do
    model
    |> Author.changeset(attrs)
    |> Repo.update
  end

  def delete_author(%Author{} = model), do: Repo.delete(model)
end