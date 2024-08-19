defmodule PhxAssocTest.Repo do
  use Ecto.Repo,
    otp_app: :phx_assoc_test,
    adapter: Ecto.Adapters.SQLite3
end
