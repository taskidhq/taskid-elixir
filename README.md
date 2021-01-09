# Taskid

[Hex](https://hex.pm/packages/taskid)
[Documentation](https://hexdocs.pm/taskid/api-reference.html)

Takid's client library for Elixir applications.

## Installation

Add `taskid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:taskid, "~> 0.2.0"}
  ]
end
```

Configure `taskid` in `config/config.exs`:

```elixir
config :taskid, applications: [
  # A list with all the applications that have Taskid tasks defined
]
```

## How to release a new version

1. Bump version in `mix.exs` and `README.md`
2. Create new section in the `CHANGELOG` for the new version (with the Unreleased changes)
3. Commit changes with a message like `Bumps version from <old version> to <new_version>`
4. Create and push git tag: `git tag <version> && git push origin <version>`
5. Publish to Hex: `mix hex.publish`
