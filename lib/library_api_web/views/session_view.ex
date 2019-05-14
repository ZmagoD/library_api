defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view

  def render("token.json", user) do
    data = %{id: user.id, email: user.email, username: user.username}

    jwt = %{data: data, sub: user.id}
    |> Joken.token
    |> Joken.sign(Joken.Signer.create("HS512", Application.get_env(:library_api, :jwt_secret)))
    %{token: jwt.token}
  end
end