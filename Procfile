release: env DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:migrate
web: rails server
frontend: bin/webpack-dev-server
worker: sidekiq
redis: redis-server