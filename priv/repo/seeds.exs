# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixFrameworkJsonApiExample.Repo.insert!(%PhoenixFrameworkJsonApiExample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias PhoenixFrameworkJsonApiExample.Repo
alias PhoenixFrameworkJsonApiExample.Test.{Todo}

Repo.insert! %Todo{author: "Max", text: "Idk"}
Repo.insert! %Todo{author: "Nicht Max", text: "Irdk"}