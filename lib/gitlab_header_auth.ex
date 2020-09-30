defmodule GitLabHeaderAuth do
  @moduledoc """
  Plug that checks that the conn (normally caused by webhooks from GitLab) has the correct `X-GitLab-Token` header.
  """

  import Plug.Conn
  require Logger

  @doc false
  def init(opts), do: opts

  @doc """
  Gets the token from the `:gitlab_header_auth` application, under `:token`, then checks the token passed in via the
  `X-GitLab-Token` header in the `conn` matches it.
  """
  def call(conn, _) do
    token = Application.get_env(:gitlab_header_auth, :token)
    check_token(conn, token)
  end

  defp check_token(conn, expected_token) when is_binary(expected_token) do
    case get_req_header(conn, "x-gitlab-token") do
      [provided_token] ->
        if provided_token == expected_token do
          conn
        else
          forbid(conn, "invalid authorisation", 403)
        end

      _ ->
        forbid(conn, "missing authorisation", 401)
    end
  end

  defp check_token(conn, token) do
    Logger.error("Received incorrect configuration: #{inspect(token)}")

    forbid(
      conn,
      "authorisation configuration is invalid - have you set `config :gitlab_header_auth, :token, [TOKEN]`?}",
      401
    )
  end

  # Deny access and send back the supplied reason.
  defp forbid(conn, reason, code) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> resp(code, "{\"error\": \"#{reason}\"}")
    |> halt()
  end
end
