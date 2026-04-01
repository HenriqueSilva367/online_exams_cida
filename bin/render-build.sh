#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Migra todos os bancos configurados no Rails 8 (primary, cache, queue, cable)
bundle exec rails db:migrate
