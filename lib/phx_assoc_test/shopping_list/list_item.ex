defmodule PhxAssocTest.ShoppingList.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :count, :integer
    field :name, :string
    belongs_to :list, PhxAssocTest.ShoppingLists.List

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:name, :count, :list_id])
    |> validate_required([:name, :count])
    |> unsafe_validate_unique([:list_id, :name], PhxAssocTest.Repo,
      error_key: :name,
      message: "This item is already on this list"
    )
    |> foreign_key_constraint(:list_id)
  end
end
