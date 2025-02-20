defmodule W.Worker do
  use Oban.Worker,
    queue: :fetch,
    unique: [
      fields: [:args, :queue, :worker],
      keys: [:name],
      period: :infinity,
      states: [:available, :retryable, :scheduled]
    ]

  @impl Oban.Worker
  def perform(%Job{args: args}) do
    %{"name" => name, "fetch_from" => fetch_from} = args

    case fetch_from do
      "cache" ->
        if is_cached?(name) do
          "all done"
        else
          create_job(%{"name" => name, "fetch_from" => "source"})
        end

      "source" ->
        {:ok, "fresh data!"}
    end
  end

  def create_job(args) do
    new(args)
    |> Oban.insert()
  end

  defp is_cached?(_name), do: false
end
