defmodule LibraryApiWeb.StatusController do
  use LibraryApiWeb, :controller

  def index(conn, _) do
    render conn, "index.json"
  end
end