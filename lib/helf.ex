defmodule HELF.App do
  use Application

  alias HELF.Router
  alias HELF.Router.Topics

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(HeBroker, []),
      worker(Topics, []),
      worker(Router, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: HELF.Supervisor]

    {:ok, _} = Supervisor.start_link(children, opts)
  end
end
