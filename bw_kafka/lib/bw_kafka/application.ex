defmodule BwKafka.Application do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      { BwKafka, [] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BwKafka.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
