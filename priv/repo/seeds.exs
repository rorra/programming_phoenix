# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query, only: [from: 2]
alias Rumbl.Repo
alias Rumbl.User
alias Rumbl.Category

if (Repo.one(from u in User, select: count(u.id)) == 0) do
  for params <- [
    %{name: "Rodrigo Dominguez", username: "rorra", password: "password"},
    %{name: "Marcos Perez", username: "marcos", password: "password"}
  ] do
    Repo.insert!(User.registration_changeset(%User{}, params))
  end
end

for category <- ~w(Action Drama Romance Comedy Sci-fi) do
  Repo.get_by(Category, name: category) ||
    Repo.insert!(%Category{name: category})
end
