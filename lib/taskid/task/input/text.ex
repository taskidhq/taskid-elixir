defmodule Taskid.Task.Input.Text do
  @behaviour Taskid.Task.Input

  alias Taskid.Task.Input

  @impl true
  def define(params) do
    %Input{
      id: params.id,
      label: params.label,
      type: "text",
      default: params.default,
      hint: params.hint,
      placeholder: params.placeholder
    }
  end
end
