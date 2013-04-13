# encoding: utf-8
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
require "rvm/capistrano"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# 如果是非root用户，设置为user, 否则为 system
set :rvm_type, :user

before "deploy:setup", "db:configure"
after "deploy:update_code", "db:symlink", "deploy:migrate", "deploy:finalize_update"

set :rails_env, "production"

set :application, "Cabbeen"
set :user, "deploy"
set :group, "deploy"
set :use_sudo, false

# 如果SSH端口修改了，改为相应的端口号
# ssh_options[:port] = 22

set :repository, "git@github.com:elvin-lian/cat.git"
set :branch, "master"
set :scm, :git
set :scm_username, "elvin-lian"
set :scm_password, ""

# 数据库用户名
set :database_username, "cabbeen"

# 数据库名
set :production_database, "cabbeen"

# 发布到的目录
set :deploy_to, "/www/cabbeen"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

role :web, "localhost" # Your HTTP server, Apache/etc
role :app, "localhost" # This may be the same as your `Web` server
role :db, "localhost", :primary => true # This is where Rails migrations will run
#role :db, "your slave db-server here"

namespace :deploy do

  desc "Make symlink for uploaded files folder"
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end

  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    set :database_password do
      Capistrano::CLI.password_prompt "Database password: "
    end

    db_config = <<-EOF
production:
  adapter: mysql2
  encoding: utf8
  pool: 5
  reconnect: true
  host: localhost
  username: #{database_username}
  password: #{database_password}
  database: #{production_database}
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end
load 'deploy/assets'