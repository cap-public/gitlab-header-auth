# GitlabHeaderAuth

[![build status](https://gitlab.com/cap-public/packages/gitlab-header-auth/badges/master/pipeline.svg)](https://gitlab.com/cap-public/packages/gitlab-header-auth/-/commits/master) [![coverage report](https://gitlab.com/cap-public/packages/gitlab-header-auth/badges/master/coverage.svg)](https://cap-public.gitlab.io/packages/gitlab-header-auth/coverage/excoveralls.html)

A [plug](https://github.com/elixir-plug/plug) to check that a request has a `X-GitLab-Auth` header, and the token in that header matches an expected value.

To set the expected value, add the following to your config: `config :gitlab_header_auth, :token, "THETOKEN"`. Remember to fetch this from the enviroment for production!

## Installation

The package can be installed by adding `gitlab_header_auth` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gitlab_header_auth, "~> 1.0"}
  ]
end
```
