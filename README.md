# GitlabHeaderAuth

[![build status](https://gitlab.com/cap-public/packages/gitlab-header-auth/badges/master/pipeline.svg)](https://gitlab.com/cap-public/packages/gitlab-header-auth/-/commits/master)
[![coverage report](https://gitlab.com/cap-public/packages/gitlab-header-auth/badges/master/coverage.svg)](https://cap-public.gitlab.io/packages/gitlab-header-auth/coverage/excoveralls.html)

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

## Usage

If using Phoenix, add `plug GitLabHeaderAuth` to the pipeline you want to authenticate - for example:

```elixir
pipeline :api do
  plug :accepts, ["json"]
  plug GitLabHeaderAuth
end
```

If you haven't set the config correctly, the plug will halt the `conn` and tell you (by returning a JSON error). It will also halt and return if the auth fails.

## Example configuration

In `config/dev.exs` add the following:

```elixir
config :gitlab_header_auth, :token, "DEVTOKEN"
```
