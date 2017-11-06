source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '5.0.0'
gem 'jquery-raty-rails', github: 'bmc/jquery-raty-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'elasticsearch-model', '~> 5.0.1'
gem 'elasticsearch-persistence', '~> 5.0.1'
gem 'elasticsearch-rails', '~> 5.0.1'

gem 'pluck_to_hash', '~> 1.0.2'
gem 'bootstrap-sass', '~> 3.3.7'

gem 'slim-rails', '~>3.1.2'

gem 'devise', '~> 4.2'
gem 'activeadmin', '~> 1.0.0.pre4'

gem 'sidekiq', '~> 5.0.4'

gem "select2-rails", '~> 4.0.3'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'forgery', '~> 0.6'

  gem 'capistrano', '~> 3.10.0',        require: false
  gem 'capistrano-rvm', '~> 0.1.2',     require: false
  gem 'capistrano-rails', '~> 1.3.0',   require: false
  gem 'capistrano3-puma', '~> 3.1.1',   require: false
  #Uncomment if some capistrano recipes need sudo support
  # gem 'sshkit-sudo'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
