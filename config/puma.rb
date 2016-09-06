workers 2

threads 1, 6

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{app_dir}/tmp"
log_dir = "#{app_dir}/log"

rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env

bind "unix:///tmp/current.sock"

# Comment out both if using byebug
daemonize
stdout_redirect "#{log_dir}/puma.stdout.log", "#{log_dir}/puma.stderr.log", true

pidfile "#{tmp_dir}/pids/puma.pid"
state_path "#{tmp_dir}/pids/puma.state"

# activate_control_app

# preload_app!

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
