defmodule Blaces.Pin do
  use Blaces.Web, :model

  @required_fields ~w(name latitude longitude)a
  @optional_fields ~w()a

  schema "pins" do
    field :name, :string
    field :latitude, :float
    field :longitude, :float
    belongs_to :user, Blaces.User
    belongs_to :bucket, Blaces.Bucket

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
