defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())

  def commands(code) do
    digitToBin(code)
  end

  @spec digitToBin(integer) :: [integer]
  def digitToBin(num) do
    Integer.digits(num, 2)
    |> Enum.reverse
    |> Enum.reduce(fn num, acc -> num * Math.power(10, acc) end)
  end
  
  def printTheMagic(binlist) when length >= 5, do: Enum.reverse(binlist) |> printTheMagic
    def printTheMagic(binlist) do
      case Enum.map(binlist, fn index -> index.binlist end) do
        1 ->
          "wink"
        10 ->
          "double blink"
        100 ->
          "close your eyes"
        1000 ->
          "jump"
      end
    end 
end

