defmodule PhoenixFrameworkJsonApiExample.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :author, :string
      add :text, :string

      timestamps()
    end

  end
end
