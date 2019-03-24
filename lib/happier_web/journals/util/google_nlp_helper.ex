defmodule Happier.NLP_UTIL do
  @base_url "https://language.googleapis.com"
  @analyze_entities @base_url <> "/v1/documents:analyzeEntities"
  @analyze_entities_sentiment @base_url <> "/v1/documents:analyzeEntitySentiment"
  @analyze_sentiment @base_url <> "/v1/documents:analyzeSentiment"
  @plain_text 2
  @key "?key="
  @english "en"
  @encoding_type_utf8 2
  @request_opts [connect_timeout: 1_000_000, recv_timeout: 1_000_000, timeout: 1_000_000]

  def add_auth(url) do
    url <> @key <> System.get_env("GCLOUD_SECRET_KEY")
  end

  def get_entities(%{entry: journal_entry}) do
    url = add_auth(@analyze_entities)
    body = form_request(journal_entry)
    response = make_request(url, body, make_header())
    process_entities_response(response)
  end

  def get_sentiment(%{entry: journal_entry}) do
    url = add_auth(@analyze_sentiment)
    IO.puts(url)
    body = form_request(journal_entry)
    response = make_request(url, body, make_header())
    process_sentiment_response(response)
  end

  def get_entities_sentiment(%{entry: journal_entry}) do
    url = add_auth(@analyze_entities_sentiment)
    body = form_request(journal_entry)
    response = make_request(url, body, make_header())
    process_entities_sentiment_response(response)
  end

  def process_sentiment_response(response) do
    case response do
      {:commit, body} ->
        body

      {_, _} ->
        %{}
    end
  end

  def process_entities_response(response) do
    case response do
      {:commit, body} ->
        body

      {_, _} ->
        %{}
    end
  end

  def process_entities_sentiment_response(response) do
    case response do
      {:commit, body} ->
        body

      {_, _} ->
        %{}
    end
  end

  def form_request(text) do
    Poison.Encoder.encode(
      %{
        document: google_nlp_document(text),
        encoding_type: @encoding_type_utf8
      },
      []
    )
  end

  def google_nlp_document(text) do
    %{
      type: @plain_text,
      language: @english,
      content: text
    }
  end

  def make_header() do
    %{
      "Content-type" => "application/json"
    }
  end

  def make_request(url, body, headers) do
    case HTTPoison.post(url, body, headers, @request_opts) do
      {:ok, response} ->
        {:commit, Poison.decode!(response.body)}

      _ ->
        {:ignore, nil}
    end
  end
end
