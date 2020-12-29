defmodule Taskid.Task.Input do
  defstruct [:id, :label, :type, :default, :hint, :placeholder]

  @type t :: %__MODULE__{}

  @callback define(map()) :: t()
end
