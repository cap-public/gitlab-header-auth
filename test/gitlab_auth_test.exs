defmodule GitlabAuthTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import Plug.Conn, only: [put_req_header: 3]
  doctest GitLabAuth

  test "correct header succeeds" do
    conn =
      conn("POST", "/")
      |> put_req_header("x-gitlab-token", "some_token")
      |> GitLabAuth.call([token: "some_token"])

    # There shouldn't be a response as the auth succeeded
    refute conn.resp_body
  end

  test "incorrect header fails" do
    conn =
      conn("POST", "/")
      |> put_req_header("x-gitlab-token", "some_tokenMODIFIED")
      # Test that other headers don't matter
      |> put_req_header("some-other-header", "some-other-info")
      |> GitLabAuth.call([token: "some_token"])

    # We sent the wrong auth information
    assert_error_response(conn, 403, "invalid authorisation")
  end

  test "missing header fails" do
    conn = GitLabAuth.call(conn("POST", "/"), [token: "some_token"])

    # We didn't send any auth information
    assert_error_response(conn, 401, "missing authorisation")
  end

  test "missing config fails" do
    conn = GitLabAuth.call(conn("POST", "/"), [])

    # The plug wasn't configured correctly
    assert_error_response(conn, 401, "authorisation configuration is invalid - expected %{token: some_token}")
  end

  defp assert_error_response(conn, status, error) do
    assert Plug.Conn.get_resp_header(conn, "content-type") == ["application/json"]
    assert conn.status == status
    assert conn.resp_body == "{\"error\": \"#{error}\"}"
  end
end
