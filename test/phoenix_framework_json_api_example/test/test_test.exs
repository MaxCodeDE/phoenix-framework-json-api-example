defmodule PhoenixFrameworkJsonApiExample.TestTest do
  use PhoenixFrameworkJsonApiExample.DataCase

  alias PhoenixFrameworkJsonApiExample.Test

  describe "todos" do
    alias PhoenixFrameworkJsonApiExample.Test.Todo

    @valid_attrs %{author: "some author", text: "some text"}
    @update_attrs %{author: "some updated author", text: "some updated text"}
    @invalid_attrs %{author: nil, text: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Test.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Test.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Test.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Test.create_todo(@valid_attrs)
      assert todo.author == "some author"
      assert todo.text == "some text"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Test.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, todo} = Test.update_todo(todo, @update_attrs)
      assert %Todo{} = todo
      assert todo.author == "some updated author"
      assert todo.text == "some updated text"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Test.update_todo(todo, @invalid_attrs)
      assert todo == Test.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Test.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Test.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Test.change_todo(todo)
    end
  end
end
