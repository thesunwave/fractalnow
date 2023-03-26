require 'puma'

workers 3
preload_app!

port ENV.fetch('PORT', 8080)
bind ENV.fetch('BIND', 'tcp://0.0.0.0')
