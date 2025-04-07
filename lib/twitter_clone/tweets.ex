defmodule TwitterClone.Tweets do
  @moduledoc """
  The Tweets context.
  """

  import Ecto.Query, warn: false
  alias TwitterClone.Repo

  alias TwitterClone.Tweets.Tweet

  def list_tweets do
    Repo.all(Tweet)
    |> Repo.preload(:user)
  end

  def get_tweet!(id), do: Repo.get!(Tweet, id)

  def create_tweet(attrs) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  def update_tweet(%Tweet{} = tweet, attrs) do
    tweet
    |> Tweet.changeset(attrs)
    |> Repo.update()
  end

  def delete_tweet(%Tweet{} = tweet) do
    Repo.delete(tweet)
  end

  def change_tweet(%Tweet{} = tweet, attrs \\ %{}) do
    Tweet.changeset(tweet, attrs)
  end
end
