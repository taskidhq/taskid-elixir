defmodule Taskid.Task do
  @moduledoc "TODO"

  @callback name() :: String.t()
  @callback description() :: String.t()
  @callback inputs() :: list(Taskid.Task.Input.t())
  @callback run(map()) :: {:ok, String.t()} | {:error, String.t()}
end
