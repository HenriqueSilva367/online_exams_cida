#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Prepara o banco (roda migrations e seeds)
bundle exec rails db:prepare
