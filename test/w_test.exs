defmodule WTest do
  use ExUnit.Case
  use Oban.Testing, repo: W.Repo

  test "job inserts a job" do
    assert {:ok, job_1} = W.Worker.create_job(%{"name" => "foo", "fetch_from" => "cache"})

    assert {:ok, job_2} = perform_job(W.Worker, job_1.args)
    assert {:ok, "fresh data!"} == perform_job(W.Worker, job_2.args)
  end
end
