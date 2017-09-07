defmodule PhoenixFrameworkJsonApiExampleWeb.Router do
  use PhoenixFrameworkJsonApiExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", PhoenixFrameworkJsonApiExampleWeb do
    pipe_through :api
    resources "/todos", TodoController
  end
end
