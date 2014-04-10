== README


These are the steps to get the system up and running: 

1. Alter gitignore

  #Ignore Additional

  .secret
  .DS_Store
  .project
  .idea
  doc/
  *.swp
  *~

2. Clean up GEMFILE with what you want - example: 

  source 'https://rubygems.org'


  source 'https://rubygems.org'
  ruby '2.0.0'

  gem 'rails', '4.0.4'
  gem 'bootstrap-sass', '2.3.2.0'
  gem 'sprockets', '2.11.0'

  gem 'will_paginate', '3.0.4'
  gem 'bootstrap-will_paginate', '0.0.9'


  gem 'sass-rails', '4.0.1'
  gem 'uglifier', '2.1.1'
  gem 'coffee-rails', '4.0.1'
  gem 'jquery-rails', '3.0.4'
  gem 'turbolinks', '1.1.1'
  gem 'jbuilder', '1.0.2'

  group :development, :test do
    gem 'sqlite3', '1.3.8'
    gem 'rspec-rails', '2.13.1'
    gem 'guard-rspec', '2.5.0'
  end

  group :test do
    gem 'selenium-webdriver', '2.35.1'
    gem 'capybara', '2.1.0'
    gem 'factory_girl_rails', '4.2.1'
  end


  group :doc do
    gem 'sdoc', '0.3.20', require: false
  end

  group :production do
    gem 'pg', '0.15.1'
    gem 'rails_12factor', '0.0.2'
  end

3. Enter : bundle install --without production

  this is to include all gem files without production gemfiles for now. 

4. Update secret token with secret_token method: 
    require 'securerandom'

    def secure_token
      token_file = Rails.root.join('.secret')
      if File.exist?(token_file)
        File.read(token_file).chomp
      else
        token = SecureRandom.hex(64)
        File.write(token_file, token)
        token
      end
    end

    (Name of Application)::Application.config.secret_key_base = secure_token

5. Enter : rails g rspec:install to config rails to use rspec instead of default Unit Test




This README would normally document whatever steps are necessary to get the
application up and running.

  Things you may want to cover:

  * Ruby version

  * System dependencies

  * Configuration

  * Database creation

  * Database initialization

  * How to run the test suite

  * Services (job queues, cache servers, search engines, etc.)

  * Deployment instructions

  * ...


  Please feel free to use a different markup language if you do not plan to run
  <tt>rake doc:app</tt>.
