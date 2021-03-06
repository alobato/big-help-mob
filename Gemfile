source 'http://rubygems.org'

# Rails!
gem 'rails', '= 3.0.0.rc2'
gem 'mysql2'
gem 'json'

# mailing list
gem 'hominid', '>= 2.1.1'

# Geoawareness and mapping stuff.
gem 'addresslogic',    '>= 1.2.1'
gem 'geokit',          '>= 1.5.0'
gem 'bhm-google-maps', '~> 0.2.0'

# Display Helpers
gem 'formtastic',            '>= 1.0.0', :git => 'git://github.com/justinfrench/formtastic.git', :branch => 'rails3'
gem 'validation_reflection', '>= 1.0.0.rc.1'
gem 'title_estuary',         '>= 1.2.0'

# Mainly Admin Area Stuff.
gem 'inherited_resources'
gem 'responders'
gem 'show_for'

# General Code Stuff
gem 'will_paginate',    '>= 3.0.pre2', :git => 'git://github.com/mislav/will_paginate.git', :ref => 'rails3'
gem 'state_machine',    '>= 0.9.0', :git => 'git://github.com/pluginaweek/state_machine.git'
gem 'pseudocephalopod', '>= 0.2.1'

# Helpers etc.
gem 'jammit',              '>= 0.5.0'
gem 'msales-carmen',       '>= 0.1.4', :require => ['carmen', 'carmen/action_view_helpers']

# Miscellaneous
gem 'liquid'
gem 'fastercsv' if RUBY_VERSION < '1.9'
gem 'uuid'
gem 'stringex'
gem 'mail_form', '>= 1.2.1'
gem 'sitemap_generator'
gem 'flickraw'
gem 'ruby-googlechart',    '>= 0.6.4', :require => 'google_chart'

gem 'SystemTimer'

# Javascript Stuff
gem 'barista',           '>= 0.5.0'
gem 'shuriken',          '>= 0.2.0'
gem 'youthtree-js',      '>= 0.2.0'

# Background workers
gem 'resque'
gem 'resque-status', :require => 'resque/status'

# View / Rendering
gem 'haml',               '>= 3.0.13'
gem 'compass',            '>= 0.10.4'
gem 'compass-960-plugin', '>= 0.9.13'
gem 'compass-colors',     '>= 0.3.1'
gem 'fancy-buttons',      '>= 0.5.4'

gem 'youthtree-settings'
gem 'youthtree-helpers'
gem 'youthtree-controller-ext'

# Auth
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'authlogic_rpx', :git => 'git://github.com/tardate/authlogic_rpx.git'
gem 'rpx_now'

gem 'awesome_print'

gem 'youthtree-capistrano', :require => nil

gem 'unicorn', :require => nil

group :production, :staging do
  gem 'newrelic_rpm', :require => nil
end

group :development do
  gem 'rails3-generators'
  gem 'annotate', :git => 'git://github.com/miyucy/annotate_models.git', :require => nil
end

group :test, :development do
  gem 'rspec',       '>= 2.0.0.beta.20'
  gem 'rspec-rails', '>= 2.0.0.beta.20'
  gem 'machinist',   '>= 2.0.0.beta2', :require => nil
  gem 'forgery', :require => nil
end

group :test do
  gem 'ZenTest'
  if `uname`.strip =~ /darwin/
    gem 'autotest-growl'
    gem 'autotest-fsevent'
  end
  gem 'remarkable', '>= 4.0.0.alpah4', :require => 'remarkable/core'
  gem 'remarkable_activerecord', '>= 4.0.0.alpah4', :require => 'remarkable/active_record'
  gem 'rr'
end

group :staging, :production do
  gem 'hoptoad_notifier'
end