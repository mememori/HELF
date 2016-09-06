defmodule HELF.Router.Topics.Request do
  @derive [Poison.Encoder]
  defstruct [:topic, :args]
end

defmodule HELF.Router.Topics do

  alias HELF.Broker

  @remaps %{
    "account.create" => "account:create",
    "account.login" => "account:login"
  }

  def handle_route(topic, args) do
    case Map.get(@remaps, topic) do
      nil ->
        do_route(topic, args)
      remap ->
        Broker.call(remap, args)
    end
  end

  defp do_route("ping", _) do
    {:ok, "pong"}
  end

  defp do_route(name, _) do
    {:error, {404, "Route `#{name}` not found."}}
  end

end

