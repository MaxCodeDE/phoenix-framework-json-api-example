defmodule PhoenixFrameworkJsonApiExampleWeb.TodoView do
  use PhoenixFrameworkJsonApiExampleWeb, :view
  use JaSerializer.PhoenixView
  
  attributes [:author, :text, :done, :inserted_at, :updated_at]
  
end
