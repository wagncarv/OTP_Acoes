defmodule OtpAcoes.Core do
  def create_data(value), do: {value, DateTime.utc_now()}
end
