defmodule Taskid.Tasks do
  def modules do
    Enum.flat_map(applications(), &taskid_task_modules_for_app/1)
  end

  defp taskid_task_modules_for_app(application) do
    :ok = Application.ensure_loaded(application)
    {:ok, all_modules} = :application.get_key(application, :modules)

    Enum.reduce(all_modules, [], fn module, acc ->
      module_behaviours = get_module_behaviours(module)

      if Enum.member?(module_behaviours, Taskid.Task) do
        [module | acc]
      else
        acc
      end
    end)
  end

  defp applications, do: Application.fetch_env!(:taskid, :applications)

  defp get_module_behaviours(module) do
    :attributes |> module.module_info() |> Keyword.get(:behaviour, [])
  end
end
