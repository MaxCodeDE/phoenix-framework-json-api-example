defmodule PhoenixFrameworkJsonApiExampleWeb.TodoControllerTest do
  use PhoenixFrameworkJsonApiExampleWeb.ConnCase

  alias PhoenixFrameworkJsonApiExample.Test
  alias PhoenixFrameworkJsonApiExample.Test.Todo

  @create_attrs %{author: "some author", text: "some text"}
  @update_attrs %{author: "some updated author", text: "some updated text"}
  @invalid_attrs %{author: nil, text: nil}

  def fixture(:todo) do
    {:ok, todo} = Test.create_todo(@create_attrs)
    todo
  end

  
  defp relationships do
    %{}
  end

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
      
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, todo_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates todo and renders todo when data is valid", %{conn: conn} do
    conn = post conn, todo_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "todo",
        "attributes" => @create_attrs,
        "relationships" => relationships
      }
    }
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, todo_path(conn, :show, id)
    data = json_response(conn, 200)["data"]
    assert data["id"] == id
    assert data["type"] == "todo"
    assert data["attributes"]["author"] == @create_attrs.author
    assert data["attributes"]["text"] == @create_attrs.text
  end

  test "does not create todo and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, todo_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "todo",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen todo and renders todo when data is valid", %{conn: conn} do
    %Todo{id: id} = todo = fixture(:todo)
    conn = put conn, todo_path(conn, :update, todo), %{
      "meta" => %{},
      "data" => %{
        "type" => "todo",
        "id" => "#{todo.id}",
        "attributes" => @update_attrs,
        "relationships" => relationships
      }
    }

    conn = get conn, todo_path(conn, :show, id)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{id}"
    assert data["type"] == "todo"
    assert data["attributes"]["author"] == @update_attrs.author
    assert data["attributes"]["text"] == @update_attrs.text
  end

  test "does not update chosen todo and renders errors when data is invalid", %{conn: conn} do
    todo = fixture(:todo)
    conn = put conn, todo_path(conn, :update, todo), %{
      "meta" => %{},
      "data" => %{
        "type" => "todo",
        "id" => "#{todo.id}",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen todo", %{conn: conn} do
    todo = fixture(:todo)
    conn = delete conn, todo_path(conn, :delete, todo)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, todo_path(conn, :show, todo)
    end
  end
end
