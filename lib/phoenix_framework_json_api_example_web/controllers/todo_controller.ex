defmodule PhoenixFrameworkJsonApiExampleWeb.TodoController do
  use PhoenixFrameworkJsonApiExampleWeb, :controller

  alias PhoenixFrameworkJsonApiExample.Test
  alias PhoenixFrameworkJsonApiExample.Test.Todo
  alias JaSerializer.Params

  def index(conn, _params) do
    todos = Test.list_todos()
    render(conn, "index.json-api", data: todos)
  end

  def create(conn, %{"data" => data = %{"type" => "todos", "attributes" => todo_params}}) do
    with {:ok, %Todo{} = todo} <- Test.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", todo_path(conn, :show, todo))
      |> render("show.json-api", data: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Test.get_todo!(id)
    render(conn, "show.json-api", data: todo)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "todos", "attributes" => todo_params}}) do
    todo = Test.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Test.update_todo(todo, todo_params) do
      render(conn, "show.json-api", data: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Test.get_todo!(id)
    with {:ok, %Todo{}} <- Test.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
