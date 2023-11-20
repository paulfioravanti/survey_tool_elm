import Config

config :back_end, cowboy_port: 4000

# Allow CORS requests from development Elm app
config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET"]
