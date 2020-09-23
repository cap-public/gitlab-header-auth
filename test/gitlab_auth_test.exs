defmodule GitlabAuthTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import Plug.Conn, only: [put_req_header: 3]
  doctest GitLabAuth

  test "init" do
    result = GitLabAuth.init([token: "some_token"])

    assert result == [token: "some_token"]
  end

  test "correct header succeeds" do
    Application.put_env(:gitlab_auth, :token, "some_token")

    conn =
      conn("POST", "/")
      |> put_req_header("x-gitlab-token", "some_token")
      |> GitLabAuth.call([])

    # There shouldn't be a response as the auth succeeded
    refute conn.resp_body
    Application.delete_env(:gitlab_auth, :token)
  end

  test "incorrect header fails" do
    Application.put_env(:gitlab_auth, :token, "some_token")

    conn =
      conn("POST", "/")
      |> put_req_header("x-gitlab-token", "some_tokenMODIFIED")
      # Test that other headers don't matter
      |> put_req_header("some-other-header", "some-other-info")
      |> GitLabAuth.call([])

    # We sent the wrong auth information
    assert_error_response(conn, 403, "invalid authorisation")
    Application.delete_env(:gitlab_auth, :token)
  end

  test "missing header fails" do
    Application.put_env(:gitlab_auth, :token, "some_token")
    conn = GitLabAuth.call(conn("POST", "/"), [])

    # We didn't send any auth information
    assert_error_response(conn, 401, "missing authorisation")
    Application.delete_env(:gitlab_auth, :token)
  end

  test "missing config fails" do
    conn = GitLabAuth.call(conn("POST", "/"), [])

    # The plug wasn't configured correctly
    expected = "authorisation configuration is invalid - have you set `config :gitlab_auth, :token, [TOKEN]`?\}"
    assert_error_response(conn, 401, expected)
  end

  defp assert_error_response(conn, status, error) do
    assert Plug.Conn.get_resp_header(conn, "content-type") == ["application/json"]
    assert conn.status == status
    assert conn.resp_body == "{\"error\": \"#{error}\"}"
  end
end
