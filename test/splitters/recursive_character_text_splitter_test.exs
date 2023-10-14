defmodule Langchain.TextSplitters.RecursiveCharacterTextSplitter do
  use Langchain.BaseCase

  alias Langchain.TextSplitters.RecursiveCharacterTextSplitter

  describe "performs a recursive character text split" do
    setup do
      {:ok, scrape_data} = File.read("test/support/test_scrape_data.txt")

      %{scrape_data: scrape_data}
    end

    test "creates documents", %{scrape_data: scrape_data} do
      RecursiveCharacterTextSplitter.create_documents([scrape_data])
    end

  end
end