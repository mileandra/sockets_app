# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SocketsApp.Repo.insert!(%SocketsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SocketsApp.{Challenges, Repo}

unless Repo.get_by(Challenges.Challenge, name: "Sencha Community Days") do
  {:ok, challenge} = Challenges.create_challenge(%{name: "Sencha Community Days"})
  Challenges.create_task(%{
    challenge_id: challenge.id,
    question: "42 is ..."
  })

  Challenges.create_task(%{
    challenge_id: challenge.id,
    question: "Never have I ever ..."
  })

  Challenges.create_task(%{
    challenge_id: challenge.id,
    question: "Sencha is ..."
  })
end
