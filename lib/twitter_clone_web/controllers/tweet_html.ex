defmodule TwitterCloneWeb.TweetHTML do
  use TwitterCloneWeb, :html

  embed_templates "tweet_html/*"

  @doc """
  Renders a tweet form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def tweet_form(assigns)
end
