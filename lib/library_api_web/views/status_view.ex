defmodule LibraryApiWeb.StatusView do
  use LibraryApiWeb, :view

  def render("index.json", _) do
    %{ status: "ok" }
  end
end