defmodule PhoenixFrameworkJsonApiExample.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :author, :string
      add :text, :string
      add :done, :boolean

      timestamps()
    end

  end
end
