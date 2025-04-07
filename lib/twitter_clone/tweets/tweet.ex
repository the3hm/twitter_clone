defmodule TwitterClone.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :content, :string

    belongs_to :user, TwitterClone.Accounts.User  # 👈 ADD THIS

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:content, :user_id])  # 👈 include :user_id here too
    |> validate_required([:content, :user_id])
  end
end
