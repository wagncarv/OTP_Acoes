defmodule OtpAcoes do
  def start_link(code, l, value) do
    Agent.start_link(fn -> [create(value)] end, name: via(code, l))
  end

  def get(code, l), do: Agent.get(via(code, l), & &1)

  def up(code, l, v),
    do:
      Agent.update(via(code, l), fn s ->
        {value, _} = hd(s)
        [create(v + value) | s]
      end)

  def create(value), do: {value, DateTime.utc_now()}

  def create(code, b, initial_value), do: DynamicSupervisor.start_child(:otp_acoes, {__MODULE__, {code, b, initial_value}})

  def via(code, l), do: {:via, Registry, {l, code}}

  def child_spec({code, b, v}), do: %{
    id: {:via, Registry, {b, code}},
    start: {OtpAcoes, :start_link, [code, b, v]}
  }
end

# OtpAcoes.start_link "bova11", :bova, 45
# OtpAcoes.get "bova11", :bova
# OtpAcoes.up "bova11", :bova, 2
