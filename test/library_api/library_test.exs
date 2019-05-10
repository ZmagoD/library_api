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
end
