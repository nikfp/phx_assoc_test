defmodule PhxAssocTestWeb.ListLive.FormComponent do
  use PhxAssocTestWeb, :live_component

  alias PhxAssocTest.ShoppingLists

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save List</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{list: list} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(ShoppingLists.change_list(list))
     end)}
  end

  @impl true
  def handle_event("validate", %{"list" => list_params}, socket) do
    changeset = ShoppingLists.change_list(socket.assigns.list, list_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"list" => list_params}, socket) do
    save_list(socket, socket.assigns.action, list_params)
  end

  defp save_list(socket, :edit, list_params) do
    case ShoppingLists.update_list(socket.assigns.list, list_params) do
      {:ok, list} ->
        notify_parent({:saved, list})

        {:noreply,
         socket
         |> put_flash(:info, "List updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_list(socket, :new, list_params) do
    case ShoppingLists.create_list(list_params) do
      {:ok, list} ->
        notify_parent({:saved, list})

        {:noreply,
         socket
         |> put_flash(:info, "List created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end