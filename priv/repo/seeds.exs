# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TwitterClone.Repo.insert!(%TwitterClone.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TwitterClone.{Accounts, Tweets}

user = Accounts.get_user_by_email("test@example.com") || 
       Accounts.register_user(%{email: "test@example.com", password: "password1234", password_confirmation: "password123"}) |> elem(1)

Tweets.create_tweet(%{content: "Hello world!", user_id: user.id})
Tweets.create_tweet(%{content: "Another tweet!", user_id: user.id})
