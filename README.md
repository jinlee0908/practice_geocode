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

==================================================================

GEOLOCATION: 

1. Created an view index file for the locations
  <ul class="locations">
  <% @locations.each do |location| %>
  <li data-id="<%= location.id %>"> <p><%= location.name %></p>
  <p>
  <%= location.street_line_1 %><br>
  <%= location.street_line_2 %><br>
  <%= location.city %>, <%= location.state %> <%= location.postal_code %>
  </p> </li>
  <% end %> </ul>

2. Created a controller location 
  def index
  @locations = Location.all
  end

3. Added to the model location except I switched store_number to item.location

  class Location < ActiveRecord::Base 
    validates :store_number, uniqueness: true
  end

Going to add Plot Points 

4. Create a namespace for the application
  # app/assets/javascripts/base.coffee
    @ExampleApp = {}

5. Render a javascript partial in the application layout body : app/views/application/_javascript.html.erb

  <%= javascript_include_tag "application", "data-turbolinks-track" => true %> 
  <%= yield :javascript %>

6. Insert the javascript partial into the application layout
    body>
      <div class="container">
        <%= yield %> 
      </div>
        <%= render 'javascript' %> 
    </body>

7. Create a Mapper javascript/coffee to display the map on the page with markers placed at correct coordinates
  
  Class @PracticeApp.Mapper 

    constructor: (cssSelector) ->
      @cssSelector = cssSelector
      @map = null
      @bounds = new PracticeApp.MapBounds

    addCoordinates: (latitude, longitude) ->
      if !_.isEmpty(latitude) and !_.isEmpty(longitude)
        @bounds.add(latitude, longitude)

    render: =>
      @map = new PracticeApp.Map(@cssSelector, @bounds)
      @map.build()

8. Create a MapBound javascript/coffee for a simple interface for interacting with Google rep. of coordinates and bounds.

  class @PracticeApp.MapBounds

  constructor: ->
    @googleLatLngBounds = new google.maps.LatLngBounds()
    @latLngs = []

  add: (latitude, longitude) ->
    latLng = new google.maps.LatLng(latitude, longitude)
    @googleLatLngBounds.extend(latLng)
    @latLngs.push(latLng)

  getCenter: ->
    @googleLatLngBounds.getCenter()
    
9. Create a Map javascript/coffee for a simple interface to Google Maps Javascript API for rendering a responsive map

  class @PracticeApp.Map
    constructor: (cssSelector, bounds) ->
      @googleMap = new google.maps.Map($(cssSelector)[0], @_mapOptions())
      @bounds = bounds

      $(window).on 'resize', =>
        google.maps.event.trigger(@googleMap, 'resize')
        @_updateCenter()

    build: ->
      @_updateCenter()
      @_plotCoordinates()

    _updateCenter: ->
      @googleMap.fitBounds @bounds.googleLatLngBounds
      @googleMap.setCenter @bounds.getCenter()

    _plotCoordinates: ->
      for latLng in @bounds.latLngs
        new google.maps.Marker(position: latLng, map: @googleMap)

    _mapOptions: ->
      zoom: 13
      mapTypeId: google.maps.MapTypeId.SATELLITE

10. added function in view to instantiate a Mapper and called  addCoordinates and render displays map and plot location

    <div id="map" style="height: 400px;"></div>
    <ul class="locations">
      <% @locations.each do |location| %>
        <%= render location %> 
      <% end %>
    </ul>

    <% content_for :javascript do %>
      <script type="text/javascript"
        src="//maps.googleapis.com/maps/api/js?sensor=false"></script>
    <%= javascript_tag do %> 
      $(function() {
        var mapper = new Practice.Mapper('#map');

        $('[data-latitude]').each(function(index, element) {
          mapper.addCoordinates(
            $(element).attr('data-latitude'),
            $(element).attr('data-longitude') 
            );
          });
          mapper.render();
        });
      <% end %>
    <% end %>

11.  add we're doing something with another partial - but not sure how to tie this together
  app/views/locations/_location.html.erb:

  <%= content_tag_for :li, location,
    data: { latitude: location.latitude, longitude: location.longitude } do %>

    <header>
      <h1 data-role="name"><%= location.name %></h1> 
        <% if location.respond_to?(:distance) %>
      <h2 data-role="distance"><%= location.distance.round(1) %> mi</h2> 
      <% end %>

    </header> 

    <section>
      <section class="location-info">
        <p data-role="address"><%= location.address %></p><br> 
        <p data-role="phone-number">
          <%= link_to location.phone_number, "tel:#{location.phone_number}" %> 
        </p>
      </section>
    </section> 
    
  <% end %>

12. Now refactor so that I don't have to deal with a postal code - removed a method and postal code reference
  app/controllers/locations_controller.rb: 

    class LocationsController < ApplicationController 
      
      def index
        @locations =  if search_value.present?
                        Location.near(search_value) 
                      else
                        Location.all
                      end 
      end

      private
      
      def search_value
        params[:search] && params[:search][:value]
      end

    end

13. Now updateing app/model/location.rb to again remove postal code etc. 

  class Location < ActiveRecord::Base

    validates :store_number, uniqueness: true
    geocoded_by :address
    after_validation :geocode

    private

    def address
      [street_line_1, street_line_2, city, state,
      postal_code, country_code].compact.join ', ' 
    end
  end

14. The geocoder gem extends the request object within Rails controllers with a new method, #location, which exposes information about both city and state. By creating a new class, RequestGeocodingGatherer, to handle calculating city and state, we’re able to keep this logic out of the controller and have small classes, each with their own responsibility:

  app/models/request_geocoding_gatherer.rb

  class RequestGeocodingGatherer 

    def initialize(request)
      @request = request 
    end

    def current_location 
      if city && state
        [city, state].join ', ' 
      else
        ''
     end
   end

    private

    delegate :city, :state, to: :location
    delegate :location, to: :@request
  
  end

15. Updated the controller to account for this new class. The new class will retrieve the current location string from the request
  app/controllers/locations_controller.rb : 

  class LocationsController < ApplicationController 
    class_attribute :request_geocoding_gatherer
    self.request_geocoding_gatherer = RequestGeocodingGatherer
    
    def index
      @current_location_by_ip = geocoded_request_information.current_location

      @locations =  if search_value.present?
                      Location.near(search_value) 
                    else
                      Location.all
                    end 
    end

    private

    def search_value
      params[:search] && params[:search][:value]
    end

    def geocoded_request_information
      request_geocoding_gatherer.new(request)
    end
  end

16. update the form with the new ability to locate address with geolocator
  app/views/locations/index.html.erb: 

17. Added  javascript to index file to pull geolocation from the user rather than the site. 
  $(function() {
  if (_.isEmpty($('#search_value').attr('placeholder'))) {
    var currentLocation = new PracticeApp.CurrentLocation();
    currentLocation.getLocation(function(location) {
    $('#search_value').attr('placeholder', location);
      })
    } 
  });

18. Create a new javascript/coffee file for the current location getter and defautl location setter.. 

  class @PracticeApp.CurrentLocation
    @DEFAULT_LOCATION = 'Portland, OR'

    constructor: (deferredResolution) ->
      @deferredResolution = deferredResolution || (defer) =>
      navigator.geolocation.getCurrentPosition(
        @_reverseGeocodeLocation(defer), defer.reject
      )

    getLocation: (callback) =>
      successCallback = (value) -> callback(value)
      failureCallback = (value) -> callback(PracticeApp.CurrentLocation.DEFAULT_LOCATION)

      $.Deferred(@deferredResolution).then(successCallback, failureCallback)

    _reverseGeocodeLocation: (deferred) => 
      (geoposition) =>
        reverseGeocoder = new PracticeApp.ReverseGeocoder(
          geoposition.coords.latitude,
          geoposition.coords.longitude
        ) 
        reverseGeocoder.location(deferred)

19. Create reversegeocoder javascript/coffee to handle interactions with the external geocoder service
  app/assets/javascripts/reverse_geocoder.coffee:
  



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
