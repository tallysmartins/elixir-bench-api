defmodule ElixirBench.Benchmarks.Benchmark do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirBench.Benchmarks.{Benchmark, Measurement}
  alias ElixirBench.Repos

  schema "benchmarks" do
    field :name, :string

    belongs_to(:repo, Repos.Repo)
    has_many(:measurements, Measurement)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Benchmark{} = benchmark, attrs) do
    benchmark
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
