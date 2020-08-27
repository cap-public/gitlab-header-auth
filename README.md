# GitlabAuth

A [plug](https://github.com/elixir-plug/plug) to check that a request has a `X-GitLab-Auth` header, and the token in that header matches an expected value (set in the Plug.Conn.call/2 opts).

## Installation

The package can be installed by adding `gitlab_auth` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gitlab_auth, git: "https://gitlab.com/elixir-lang/gettext.git", tag: "0.1"}
    {:gitlab_auth, git: "~> 0.1.0"}
  ]
end
```
