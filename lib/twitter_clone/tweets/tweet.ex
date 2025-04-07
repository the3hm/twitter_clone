defmodule TwitterClone.Tweets.Tweet do
  @moduledoc """
  Represents tweets and contains logic for creating and querying tweets.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :content, :string

    # 👈 ADD THIS
    belongs_to :user, TwitterClone.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    # 👈 include :user_id here too
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content, :user_id])
  end
end
