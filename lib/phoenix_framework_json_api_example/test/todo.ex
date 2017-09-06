defmodule PhoenixFrameworkJsonApiExample.Test.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixFrameworkJsonApiExample.Test.Todo


  schema "todos" do
    field :author, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:author, :text])
    |> validate_required([:author, :text])
  end
end
