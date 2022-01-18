defmodule OtpAcoes do
  use GenServer

  def init(init_arg), do: {:ok, init_arg}

  def start_link(code, l, value) do
    GenServer.start_link(__MODULE__, [create(value)], name: via(code, l))
  end

  def get(code, l), do: GenServer.call(via(code, l), :get)
  def up(code, l, value), do: GenServer.cast(via(code, l), {:up, value})

  def create(value), do: {value, DateTime.utc_now()}

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:up, v}, state) do
    {value, _} = state |> hd()
    {:noreply, [create(v + value) | state]}
  end

  def via(code, l), do: {:via, Registry, {l, code}}
end
