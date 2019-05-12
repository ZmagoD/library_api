defmodule LibraryApiWeb.ErrorView do
  use LibraryApiWeb, :view

  def render("400.json", %Ecto.Changeset{} = changeset) do
    JaSerializer.EctoErrorSerializer.format(changeset)
  end


  def render("401.json", %{detail: detail}) do
    %{status: 401, title: "Unauthorized", detail: detail}
    |> JaSerializer.ErrorSerializer.format()
  end

  def render("404.json", _assigns) do
    %{title: "Page not found", status: 404}
    |> JaSerializer.ErrorSerializer.format()
  end

  def render("500.json", assigns) do
    IO.inspect assigns

    %{title: "Internal server error", status: 500}
    |> JaSerializer.ErrorSerializer.format()
  end

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, assigns) do
    render "500.json", assigns
  end
end
