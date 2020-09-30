defmodule GitlabHeaderAuth.MixProject do
  use Mix.Project

  @version "1.1.1"
  @source_url "https://gitlab.com/cap-public/packages/gitlab-header-auth/"

  def project do
    [
      app: :gitlab_header_auth,
      source_url: @source_url,
      homepage_url: @source_url,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.html": :test],
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.10.4"},
      {:excoveralls, "~> 0.13.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]}
    ]
  end

  defp description do
    "A plug to check a request has the correct `X-GitLab-Auth` header."
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitLab" => @source_url}
    ]
  end
end
