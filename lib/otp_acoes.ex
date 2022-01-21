defmodule OtpAcoes do
  alias OtpAcoes.Server

  def create(code, b, initial_value),
    do: DynamicSupervisor.start_child(:otp_acoes, {Server, {code, b, initial_value}})

  def status(code, l), do: Server.get(code, l)
  def update(code, l, v), do: Server.up(code, l, v)
end

# OtpAcoes.start_link "bova11", :bova, 45
# OtpAcoes.get "bova11", :bova
# OtpAcoes.up "bova11", :bova, 2
