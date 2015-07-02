rake assets:precompile
rake db:seed
puma -e docker -C config/puma.rb
service nginx restart
tail -f log/docker.log