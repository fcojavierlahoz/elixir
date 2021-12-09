defmodule BwKafka.Application do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      { BwKafka, [] },
      { MyXQL, host: "localhost", protocol: :tcp, database: "test", username: "root", password: "password", name: :myxql},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BwKafka.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
