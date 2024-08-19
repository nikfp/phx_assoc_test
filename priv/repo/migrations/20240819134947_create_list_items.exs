defmodule PhxAssocTest.Repo.Migrations.CreateListItems do
  use Ecto.Migration

  def change do
    create table(:list_items) do
      add :name, :string
      add :count, :integer
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:list_items, [:list_id])
    create unique_index(:list_items, [:list_id, :name])
  end
end
