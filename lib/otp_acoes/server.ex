defmodule OtpAcoes.Server do
  alias OtpAcoes.Core

  def start_link(code, l, value) do
    Agent.start_link(fn -> [Core.create_data(value)] end, name: via(code, l))
  end

  def get(code, l), do: Agent.get(via(code, l), & &1)

  def via(code, l), do: {:via, Registry, {l, code}}

  def up(code, l, v),
    do:
      Agent.update(via(code, l), fn s ->
        {value, _} = hd(s)
        [Core.create_data(v + value) | s]
      end)

  def child_spec({code, b, v}),
    do: %{
      id: {:via, Registry, {b, code}},
      start: {__MODULE__, :start_link, [code, b, v]}
    }
end
