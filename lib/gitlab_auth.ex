defmodule GitLabAuth do
  @moduledoc """
  Plug that checks that the conn (normally caused by webhooks from GitLab) has the correct `X-Gitlab-Token` header.
  """

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, [token: expected_token]) when is_binary(expected_token) do
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

  def call(conn, _) do
    forbid(conn, "authorisation configuration is invalid - expected %{token: some_token}", 401)
  end

  # Deny access and send back the supplied reason.
  defp forbid(conn, reason, code) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> resp(code, "{\"error\": \"#{reason}\"}")
    |> halt()
  end
end

