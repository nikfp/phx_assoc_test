defmodule PhxAssocTest.ShoppingLists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :title, :string

    has_many :list_items, PhxAssocTest.ShoppingList.ListItem, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:list_items,
      with: &PhxAssocTest.ShoppingList.ListItem.changeset/2,
      sort_param: :list_item_sort,
      drop_param: :list_item_drop
    )
  end
end
