defmodule TwitterCloneWeb.TweetControllerTest do
  use TwitterCloneWeb.ConnCase

  import TwitterClone.TweetsFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  describe "index" do
    test "lists all tweets", %{conn: conn} do
      conn = get(conn, ~p"/tweets")
      assert html_response(conn, 200) =~ "Listing Tweets"
    end
  end

  describe "new tweet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/tweets/new")
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "create tweet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tweets", tweet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/tweets/#{id}"

      conn = get(conn, ~p"/tweets/#{id}")
      assert html_response(conn, 200) =~ "Tweet #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tweets", tweet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "edit tweet" do
    setup [:create_tweet]

    test "renders form for editing chosen tweet", %{conn: conn, tweet: tweet} do
      conn = get(conn, ~p"/tweets/#{tweet}/edit")
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "update tweet" do
    setup [:create_tweet]

    test "redirects when data is valid", %{conn: conn, tweet: tweet} do
      conn = put(conn, ~p"/tweets/#{tweet}", tweet: @update_attrs)
      assert redirected_to(conn) == ~p"/tweets/#{tweet}"

      conn = get(conn, ~p"/tweets/#{tweet}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, tweet: tweet} do
      conn = put(conn, ~p"/tweets/#{tweet}", tweet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "delete tweet" do
    setup [:create_tweet]

    test "deletes chosen tweet", %{conn: conn, tweet: tweet} do
      conn = delete(conn, ~p"/tweets/#{tweet}")
      assert redirected_to(conn) == ~p"/tweets"

      assert_error_sent 404, fn ->
        get(conn, ~p"/tweets/#{tweet}")
      end
    end
  end

  defp create_tweet(_) do
    tweet = tweet_fixture()
    %{tweet: tweet}
  end
end
