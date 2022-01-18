defmodule OtpAcoes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Registry, [keys: :unique, name: :bova]
      },
      {
        Registry, [keys: :unique, name: :nasdaq]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OtpAcoes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
