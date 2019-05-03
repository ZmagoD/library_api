defmodule LibraryApiWeb.AuthorView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/authors/:id"
  attributes [:first, :last]
end