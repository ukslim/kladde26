#!/bin/sh
# Ruby 3.3 is Homebrew keg-only and not on PATH by default.
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
exec bundle exec jekyll serve "$@"
