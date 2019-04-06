alias SocketsApp.Accounts.User
alias SocketsApp.Challenges.{Challenge, Team, Task, Answer}

defimpl Jason.Encoder, for: [User, Challenge, Team, Task, Answer] do
  def encode(struct, opts) do
    Enum.reduce(Map.from_struct(struct), %{}, fn
      ({:__meta__, _}, acc) -> acc
      ({_k, %Ecto.Association.NotLoaded{}}, acc) -> acc
      ({k, v}, acc) -> Map.put(acc, k, v)
    end)
    |> Jason.Encode.map(opts)
  end
end
