defmodule LibraryApiWeb.UserView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/users/:id"
  attributes [:email, :username]
end