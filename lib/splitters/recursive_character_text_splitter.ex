defmodule Langchain.Splitters.RecursiveCharacterTextSplitter do
  use Langchain.TextSplitter


  @default_separators ["\n\n", "\n", " ", ""]
  @default_keep_separator true

  @impl Langchain.TextSplitter
  def init(opts \\ []) do
    Keyword.put(opts, :separators, @default_separators)
    Keyword.put(opts, :keep_separator, @default_keep_separator)
  end

  @impl Langchain.TextSplitter
  def split_text(text, opts) do
    keep_separator = Keyword.get(opts, :keep_separator)
    chunk_size = Keyword.get(opts, :chunk_size, @ts_default_chunk_size)
    separator = Keyword.get(opts, :separators, @default_separators)
    |> Enum.find("", fn separator -> String.contains?(text, separator) end )
    # Now we need to split the text on that separator
    splits = split_on_separator(text, separator, keep_separator)

    Enum.each(splits, fn text ->
      if (String.length(text) < chunk_size) do
        good_splits
      end
    end)

  end

  defp ()
end
