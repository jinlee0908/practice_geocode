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