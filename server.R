function(input, output, session) {
  
  year_total <- reactive({
    print(input$sliderYear)
    year.total[which(year.total$Year <= input$sliderYear), ]
  })
  
  observe({
    data <- year_total()[1:5,]
    data$Colour <- c("blue", 'yellow', 'red', 'orange', 'green')
    data <- select(data, Total, Colour) %>% as.data.frame() %>% toJSON
    print(data)
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



