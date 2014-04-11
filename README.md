== README


These are the steps to get the system up and running: 

1. Add to gitignore

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
    creates a .rspec
              spec (folder)
              spec/spec_helper.rb

6. Revised: Enter rails g scaffold Location address:string latitude:float longitude:float
      invoke  active_record
      create    db/migrate/20140410200849_create_locations.rb
      create    app/models/location.rb
      invoke    rspec
      create      spec/models/location_spec.rb
      invoke  resource_route
       route    resources :locations
      invoke  jbuilder_scaffold_controller
      create    app/controllers/locations_controller.rb
      invoke    erb
      create      app/views/locations
      create      app/views/locations/index.html.erb
      create      app/views/locations/edit.html.erb
      create      app/views/locations/show.html.erb
      create      app/views/locations/new.html.erb
      create      app/views/locations/_form.html.erb
      invoke    rspec
      create      spec/controllers/locations_controller_spec.rb
      create      spec/views/locations/edit.html.erb_spec.rb
      create      spec/views/locations/index.html.erb_spec.rb
      create      spec/views/locations/new.html.erb_spec.rb
      create      spec/views/locations/show.html.erb_spec.rb
      create      spec/routing/locations_routing_spec.rb
      invoke      rspec
      create        spec/requests/locations_spec.rb
      invoke    helper
      create      app/helpers/locations_helper.rb
      invoke      rspec
      create        spec/helpers/locations_helper_spec.rb
      invoke    jbuilder
       exist      app/views/locations
      create      app/views/locations/index.json.jbuilder
      create      app/views/locations/show.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/locations.js.coffee
      invoke    scss
      create      app/assets/stylesheets/locations.css.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.css.scss

6. ###Enter: rails g model location address:string latitude:float longitude:float
    invoke  active_record
    create    db/migrate/20140410220518_create_locations.rb
    create    app/models/location.rb
    invoke    rspec
    create      spec/models/location_spec.rb

7. Entered - note maybe change this to Pages: rails g controller StaticPages home search_list --no-test-framework
  To get the views for the home and search_list pages
  good or bad this is what generated - this include default routes to home and search_lists:
    create  app/controllers/static_pages_controller.rb
       route  get "static_pages/search_list"
       route  get "static_pages/home"
      invoke  erb
      create    app/views/static_pages
      create    app/views/static_pages/home.html.erb
      create    app/views/static_pages/search_list.html.erb
      invoke  helper
      create    app/helpers/static_pages_helper.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/static_pages.js.coffee
      invoke    scss
      create      app/assets/stylesheets/static_pages.css.scss

8. Enter: rails g integration_test static_pages
    This creates an rspec pages test file
    invoke  rspec
    create    spec/requests/static_pages_spec.rb

9. Created 'check home and search_list page tests in static_pages_spec'

10. Add a line to include Capybara DSL to Rspec helper file
  RSpec.configure do |config|
  .
  .
    config.include Capybara::DSL
  end

11. Revised application page tests to incorporate provide title helpers
  was done in the application.html.erb (added the title change)
  and then the title and provide ruby code was added

12. Added a title helper in the app/helpers/application_helper
  module ApplicationHelper
    def full_title(page_title)
      base_title = "Garden Exchange"
      if page_title.empty?
        base_title
      else
        "#{base_title} | #{page_title}"
      end
    end
  end

13. Revised tests and home and search_list pages



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
