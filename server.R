function(input, output, session) {
  
  year_total <- reactive({
    print(input$sliderYear)
    data <- year.total[which(year.total$Year <= input$sliderYear), ]
    data$Colour <- get_color(n = nrow(data))
    data %>% select(Year, Total, Colour) %>% as.data.frame()
  })
  
  observe({
    data <- year_total()
    session$sendCustomMessage(type = "yearTotalJs", data %>% toJSON)
  })
  
  observeEvent(input$random, {
    data <- year_total()
    data$Total <- runif(nrow(data), min = min(data$Total), max = max(data$Total))
    data <- select(data, Year, Total, Colour) %>% as.data.frame() %>% toJSON
    session$sendCustomMessage(type = "yearTotalJs", data)
  })
  
  output$d3YearTotal <- renderUI({
    includeScript('www/d3plot.js')
  })
  
  ###### ------ leaflet
  output$leaflet <- renderLeaflet({
    
    # leaf <- leaflet() %>%
    #   addTiles(urlTemplate = mapbox_url, group = 'Satelite') %>%
    #   addPolygons(data = logged, fillColor = ~pal_logged()(YearHarv), color = 'black',
    #               weight = 0, label = ~YearHarv,
    #               # options = pathOptions(pane = "watershed_all"),
    #               labelOptions = labelOptions(noHide = FALSE),
    #               fillOpacity = 0.8,
    #               highlight = highlightOptions(
    #                 weight = 1.5,
    #                 color = "black",
    #                 fillOpacity = 0.3))
      
  })
  
  ### --- colour palette
  pal_logged <- reactive({
    colorNumeric("viridis", domain = logged$YearHarv, na.color = 'grey')
  })
  
}



