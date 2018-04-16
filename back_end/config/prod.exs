use Mix.Config

# Listen on Heroku's $PORT
port =
  case System.get_env("PORT") do
    port when is_binary(port) ->
      String.to_integer(port)

    # default port
    nil ->
      80
  end

config :back_end, cowboy_port: port
