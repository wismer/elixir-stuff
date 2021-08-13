defmodule Bencode do
  # defguard is_dict(char) do char == "d" end
  # defguard is_integer(char) do char == "i" end
  # defguard is_list(char) do char == "l" end

  def start(file_path) do
    {:ok, pid} = File.open(file_path)
    parse_char(pid)
  end

  defp parse_char(pid) do
    <<char, rest::binary>> = IO.read(pid, :all)

    case char do
      ?d -> parse_dict(rest)
      ?i -> parse_int(rest)
      ?l -> parse_list(rest)
      _ -> parse_str(rest)
    end
  end

  defp parse_list(buffer) do
    :ok
  end

  defp parse_length(<<>>, acc) do
    acc
  end

  defp parse_length(<<next, rest::binary>>, n) when next != ?: do
    if n == nil do
      parse_length(rest, to_string(<<next>>))
    else
      parse_length(rest, n <> to_string(<<next>>))
    end
  end

  defp parse_length(<<next, rest::binary>>, n) do
    {num, _} = Integer.parse(n)
    IO.puts("#{num} Shit")
    {num, rest}
  end

  defp parse_dict(buffer) do
    # key first

    { length, buffer } = parse_length(buffer, "")
  end

  defp parse_int(buffer) do
    :ok
  end

  defp parse_str(buffer) do
    :ok
  end
end


defmodule BencodeFile do
  @enforce_keys [:pid]
  defstruct [:announce, :info, :pid]
end

# 1. read first byte/digit/char to determine type
# 2. read & parse second for length
# 3. d = dictionary, length describes the key. After length, another digit(s) are found, = length of value

Bencode.start("../../../Downloads/alice.torrent")
