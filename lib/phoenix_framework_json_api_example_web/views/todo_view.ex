defmodule PhoenixFrameworkJsonApiExampleWeb.TodoView do
  use PhoenixFrameworkJsonApiExampleWeb, :view
  use JaSerializer.PhoenixView
  
  attributes [:author, :text, :inserted_at, :updated_at]
  
end
