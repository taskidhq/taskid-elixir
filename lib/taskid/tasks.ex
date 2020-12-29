defmodule Taskid.Tasks do
  def modules do
    # TODO: make app name configurable
    :ok = Application.ensure_loaded(:taskid_demo_app)
    {:ok, all_modules} = :application.get_key(:taskid_demo_app, :modules)

    Enum.reduce(all_modules, [], fn module, acc ->
      module_behaviours = get_module_behaviours(module)

      if Enum.member?(module_behaviours, Taskid.Task) do
        [module | acc]
      else
        acc
      end
    end)
  end

  defp get_module_behaviours(module) do
    :attributes |> module.module_info() |> Keyword.get(:behaviour, [])
  end
end
