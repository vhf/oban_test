import Config

config :w, ecto_repos: [W.Repo]

config :w, Oban,
  engine: Oban.Pro.Engines.Smart,
  repo: W.Repo,
  queues: [
    fetch: 10
  ],
  # Disable plugins, enqueueing scheduled jobs and job dispatching altogether when testing
  testing: :manual

config :w, W.Repo,
  username: "postgres",
  password: "postgres",
  database: "w_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :logger, level: :debug
