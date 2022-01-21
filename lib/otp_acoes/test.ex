defmodule Test do
  # RESPOSTA 1
  def century(year), do: to_century(year)
  defp to_century(year) when rem(year, 100) == 0, do: div(year, 100)
  defp to_century(year), do: div(year, 100) + 1

  # -----------------------------------------

  # RESPOSTA 2
  def count(points) do
    points
    |> transform()
    |> Enum.reduce(0, fn e, points -> verify(e) + points end)
  end

  defp verify([e1, e2]) when e1 > e2, do: 3
  defp verify([e1, e2]) when e1 < e2, do: 0
  defp verify([e1, e2]) when e1 == e2, do: 1

  defp transform(points) do
    points
    |> Enum.map(fn e ->
      String.split(e, ":")
      |> Enum.map(fn e ->
        String.trim(e)
        |> String.to_integer()
      end)
    end)
  end
end

# entrada: 1705, resultado: 18

# entrada: 1900, resultado: 19

# entrada: 1601, resultado: 17

# entrada: 2000, resultado: 20
