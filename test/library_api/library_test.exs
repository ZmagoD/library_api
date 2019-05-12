defmodule LibraryApi.LibraryTest do
  use LibraryApi.DataCase

  alias LibraryApi.Library

  describe "reviews" do
    alias LibraryApi.Library.Review

    @valid_attrs %{body: "some body", user: "some user"}
    @update_attrs %{body: "some updated body", user: "some updated user"}
    @invalid_attrs %{body: nil, user: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Library.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Library.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = Library.create_review(@valid_attrs)
      assert review.body == "some body"
      assert review.user == "some user"
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, %Review{} = review} = Library.update_review(review, @update_attrs)
      assert review.body == "some updated body"
      assert review.user == "some updated user"
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_review(review, @invalid_attrs)
      assert review == Library.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Library.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Library.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Library.change_review(review)
    end
  end

  describe "users" do
    alias LibraryApi.Library.User

    @valid_attrs %{email: "some email", password_hash: "some password_hash", username: "some username"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", username: "some updated username"}
    @invalid_attrs %{email: nil, password_hash: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Library.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Library.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Library.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Library.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_user(user, @invalid_attrs)
      assert user == Library.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Library.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Library.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Library.change_user(user)
    end
  end
end
