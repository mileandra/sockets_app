defmodule SocketsApp.ValidationHelpers do

  import Ecto.Changeset

  def validate_belongs_to(changeset, name) do
    {:assoc, %{owner_key: key}} = changeset.types[name]
    if changeset.changes[key] do
      assoc_constraint(changeset, name)
    else
      cast_assoc(changeset, name, required: true)
    end
 end
end
