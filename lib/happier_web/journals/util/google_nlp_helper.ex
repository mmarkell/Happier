defmodule Happier.NLP_UTIL do
  @base_url "https://language.googleapis.com"
  @analyze_entities @base_url <> "/v1/documents:analyzeEntities"
  @analyze_entities_sentiment @base_url <> "/v1/documents:analyzeEntitySentiment"
  @analyze_sentiment @base_url <> "/v1/documents:analyzeSentiment"
  @plain_text 2
  @english "en"
  @encoding_type_utf8 2
  @request_opts [connect_timeout: 1_000_000, recv_timeout: 1_000_000, timeout: 1_000_000]

  def get_entities(%{entry: journal_entry}) do
    url = @analyze_entities
    body = form_request(journal_entry)
    make_request(url, body, make_header(token()))
  end

  def get_sentiment(%{entry: journal_entry}) do
    url = @analyze_sentiment
    IO.puts(url)
    body = form_request(journal_entry)
    make_request(url, body, make_header(token()))
  end

  def get_entities_sentiment(%{entry: journal_entry}) do
    url = @analyze_entities_sentiment
    body = form_request(journal_entry)
    make_request(url, body, make_header(token()))
  end

  def process_sentiment_response(response) do
    response
  end

  def process_entities_response(response) do
    response
  end

  def process_entities_sentiment_response(response) do
    response
  end

  def form_request(text) do
    %{
      document: google_nlp_document(text),
      encoding_type: @encoding_type_utf8
    }
  end

  def google_nlp_document(text) do
    %{
      type: @plain_text,
      language: @english,
      content: text
    }
  end

  def make_header(token) do
    %{
      "Authorization" => "Bearer #{token}",
      "Content-type" => "application/json"
    }
  end

  def make_request(url, body, headers) do
    case HTTPoison.post(url, body, headers, @request_opts) do
      {:ok, response} -> {:commit, Poison.decode!(response.body)}
      _ -> {:ignore, nil}
    end
  end

  def token() do
    url = "https://www.googleapis.com/oauth2/v4/token"
    body = token_request_body()

    case HTTPoison.post(
           url,
           body,
           make_header(""),
           @request_opts
         ) do
      {:ok, response} ->
        IO.puts(response)
        response.body.access_token

      _ ->
        ""
    end
  end

  def token_request_body() do
    Poison.Encoder.encode(
      %{
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion:
          "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJIYXBwaWVyIiwiZXhwIjoxNTU1NzIxNDk2LCJpYXQiOjE1NTMxMjk0OTYsImlzcyI6IkhhcHBpZXIiLCJqdGkiOiJjNzgxNmNjOC04Y2QxLTRmMDctOWZjNS1mMWRiYjQ1MTBhMmQiLCJuYmYiOjE1NTMxMjk0OTUsInN1YiI6IjEiLCJ0eXAiOiJhY2Nlc3MifQ.hi_awYD8P1kFjrfLIHbgBy8UfBfGaYYg-xi4heQdOjhr1IoaM35XMdxBWC5lZn3579f_K9ru7UiOMf_pr5-_hg"
      },
      []
    )
  end

  def make_jwt() do
    params = %{
      iss: "happier@happier.iam.gserviceaccount.com",
      scope: "https://www.googleapis.com/auth/devstorage.readonly",
      aud: "https://www.googleapis.com/oauth2/v4/token",
      exp: DateTime.utc_now(),
      iat: NaiveDateTime.add(DateTime.to_naive(DateTime.utc_now()), 60)
    }

    case Guardian.encode_and_sign(System.get_env("GOOGLE_APPLICATION_CREDENTIALS"), params) do
      {:ok, jwt, _full_claims} -> jwt
      {_, _, _} -> ""
    end
  end
end
