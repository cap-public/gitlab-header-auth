defmodule GitlabHeaderAuth.MixProject do
  use Mix.Project

  def project do
    [
      app: :gitlab_header_auth,
      source_url: "https://gitlab.com/cap-public/packages/gitlab-header-auth/",
      homepage_url: "https://gitlab.com/cap-public/packages/gitlab-header-auth/",
      version: "1.0.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.html": :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:excoveralls, "~> 0.13.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
    ]
  end

  defp description do
    "A plug to check a request has the correct `X-GitLab-Auth` header."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitLab" => "https://gitlab.com/cap-public/packages/gitlab-header-auth/"},
    ]
  end
end
