defmodule PhxAssocTest.ShoppingListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxAssocTest.ShoppingLists` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> PhxAssocTest.ShoppingLists.create_list()

    list
  end
end
