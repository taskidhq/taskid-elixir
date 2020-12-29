defmodule Taskid.Plug do
  @behaviour Plug

  import Plug.Conn, only: [send_resp: 3, halt: 1, put_resp_header: 3]

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(%Plug.Conn{method: "GET", request_path: "/tasks"} = conn, _opts) do
    task_modules = Taskid.Tasks.modules()

    tasks_payload =
      Enum.map(task_modules, fn module ->
        %{
          id: module,
          name: module.name(),
          description: module.description()
        }
      end)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(tasks_payload))
    |> halt()
  end

  @impl Plug
  def call(%Plug.Conn{method: "GET", request_path: "/tasks/" <> task_id} = conn, _opts) do
    task_modules = Taskid.Tasks.modules()

    if task_id in Enum.map(task_modules, &Atom.to_string/1) do
      task_module = String.to_atom(task_id)

      task_payload = %{
        id: task_module,
        name: task_module.name(),
        description: task_module.description(),
        inputs: Enum.map(task_module.inputs(), &Map.from_struct/1)
      }

      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(200, Jason.encode!(task_payload))
      |> halt()
    else
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(404, nil)
      |> halt()
    end
  end

  @impl Plug
  def call(%Plug.Conn{method: "POST", request_path: "/tasks/" <> task_id} = conn, _opts) do
    task_modules = Taskid.Tasks.modules()

    if task_id in Enum.map(task_modules, &Atom.to_string/1) do
      task_module = String.to_atom(task_id)

      input =
        Enum.reduce(conn.body_params["_json"], %{}, fn input_param, acc ->
          Map.put(acc, input_param["id"], input_param["value"])
        end)

      {_, result} = task_module.run(input)

      conn
      |> send_resp(200, result)
      |> halt()
    else
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(404, nil)
      |> halt()
    end
  end

  @impl Plug
  def call(conn, _opts), do: conn
end
