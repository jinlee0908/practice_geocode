class @PracticeApp.Mapper 

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