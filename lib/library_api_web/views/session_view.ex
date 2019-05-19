defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view

  def render("token.json", user) do
    signer = Joken.Signer.create("HS512", Application.get_env(:library_api, :jwt_secret))
    {:ok, token} = Joken.Signer.sign(%{id: user.id, email: user.email, username: user.username}, signer)
    %{token: token}
  end
end