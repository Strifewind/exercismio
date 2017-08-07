defmodule SecretHandshake do
  use Bitwise, only_operators: true
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
  @codes [wink: 0b1, double_blink: 0b10, close_your_eyes: 0b100, jump: 0b1000, reverse: 0b10000]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    decode(code)
    |> reverse_it
    |> to_s
  end
  
  @spec decode(code :: integer) :: list({atom, integer})
  defp decode(code) do
    Enum.filter(@codes, fn 
      {event, flag} ->
        (code &&& flag) == flag
    end)
  end

  @spec reverse_it(decoded_list :: list({atom, integer})) :: list({atom, integer})
  defp reverse_it(decoded_list) do
    case Keyword.has_key?(decoded_list, :reverse) do
      true ->
        [_ | tail] = Enum.reverse(decoded_list)
        tail
      false -> 
        decoded_list
    end
  end 

  @spec to_s(pattern :: list({atom, integer})) :: list(String.t())
  defp to_s(pattern) do
    Keyword.keys(pattern)
    |> Enum.map(fn code -> Atom.to_string(code) end)
    |> remove_that_sp
  end

  @spec remove_that_sp(stringlist :: list(String.t())) :: list(String.t())
  defp remove_that_sp(stringlist) do
    Enum.map(stringlist, fn code -> String.replace(code, "_", " ") end)
  end
end

