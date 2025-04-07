defmodule TwitterClone.TweetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TwitterClone.Tweets` context.
  """

  @doc """
  Generate a tweet.
  """
  def tweet_fixture(attrs \\ %{}) do
    {:ok, tweet} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> TwitterClone.Tweets.create_tweet()

    tweet
  end
end
