defmodule OtpAcoes do
  use GenServer

  def init(init_arg), do: {:ok, init_arg}

  def start_link(code, value) do
    GenServer.start_link(__MODULE__, [create(value)], name: code)
  end

  def get(code), do: GenServer.call(code, :get)
  def up(code, value), do: GenServer.cast(code, {:up, value})

  def create(value), do: {value, DateTime.utc_now()}

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:up, v}, state) do
    {value, _} = state |> hd()
    {:noreply, [create(v + value) | state]}
  end
end
