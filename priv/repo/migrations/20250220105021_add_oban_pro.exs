defmodule W.Repo.Migrations.AddObanPro do
  use Ecto.Migration

  defdelegate change, to: Oban.Pro.Migrations.Producers
end
