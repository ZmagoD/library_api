defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view

  def render("token.json", user) do
    data = %{id: user.id, email: user.email, username: user.username}

    jwt = %{data: data, sub: user.id}
    |> Joken.token
    |> Joken.signer(Joken.hs512(Application.get_env(:library_api, :jwt_secret)))
    |> Joken.sign

    %{token: jwt.token}
  end
end