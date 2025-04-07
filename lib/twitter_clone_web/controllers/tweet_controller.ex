defmodule TwitterCloneWeb.TweetController do
  use TwitterCloneWeb, :controller

  alias TwitterClone.Tweets
  alias TwitterClone.Tweets.Tweet

  def index(conn, _params) do
    tweets = Tweets.list_tweets()
    render(conn, :index, tweets: tweets)
  end

  def new(conn, _params) do
    changeset = Tweets.change_tweet(%Tweet{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    user = conn.assigns.current_user
    tweet_params = Map.put(tweet_params, "user_id", user.id)

    case Tweets.create_tweet(tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet created successfully.")
        |> redirect(to: ~p"/tweets/#{tweet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    render(conn, :show, tweet: tweet)
  end

  def edit(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    changeset = Tweets.change_tweet(tweet)
    render(conn, :edit, tweet: tweet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Tweets.get_tweet!(id)

    case Tweets.update_tweet(tweet, tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet updated successfully.")
        |> redirect(to: ~p"/tweets/#{tweet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, tweet: tweet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    {:ok, _tweet} = Tweets.delete_tweet(tweet)

    conn
    |> put_flash(:info, "Tweet deleted successfully.")
    |> redirect(to: ~p"/tweets")
  end
end
