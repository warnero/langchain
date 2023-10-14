defmodule Langchain.TextSplitter do
  alias Langchain.Document

  @ts_default_chunk_size 1000
  @ts_default_chunk_overlap 200
  @ts_default_keep_separator false
  @default_opts  [
    chunk_size: @ts_default_chunk_size,
    chunk_overlap: @ts_default_chunk_overlap,
    keep_separator: @ts_default_keep_separator
  ]

  @type opts ::
          binary
          | tuple
          | atom
          | integer
          | float
          | [opts]
          | %{optional(opts) => opts}
          | MapSet.t()
  @callback init(opts) :: opts
  @callback split_text(text :: binary, opts) :: Document.t()

  defmacro __using__(opts \\ []) do
    quote do
      opts = unquote(opts)
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      # @spec create_documents(
      #         texts :: [String.t()],
      #         metadatas :: [map()],
      #         chunk_header_options :: Keyword.t(),
      #         opts :: Keyword.t()
      #       ) :: %{}
      def create_documents(texts) do
        opts = init()
        Enum.each(texts, fn text -> split_text(text, opts) end)
      end

      def split_on_separator(text, separator, keep_separator, opts) when String.length(text) < opts.chunk_size, do: text
      def split_on_separator(text, separator, keep_separator, opts) do
          splits =
            if (keep_separator) do
              regex_escaped_separator = "(?=" <> String.replace(separator, "/[/\-\\^$*+?.()|[\]{}]", "\\$&", global: true) <> ")"
              {:ok, regex} = Regex.compile(regex_escaped_separator) |> IO.inspect(label: "my regex")
              String.split(text, regex)
            else
              String.split(text, separator)
            end
      end

    end
  end
end
