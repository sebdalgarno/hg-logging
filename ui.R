ui = tagList(
  useShinyjs(),
  tags$head(includeCSS("www/style.css")),
  tags$script(src = "https://d3js.org/d3.v4.min.js"),
  tags$head(includeScript("www/d3plot.js")),
  
  fluidPage(
    fluidRow(column(4, 
                    div(id = 'divPlot',
                        uiOutput('d3YearTotal')
                    )
    ),
    column(8,
           absolutePanel(
             leafletOutput('leaflet'), top = 0, left = 0, 
             right = 0, bottom = 0, height = 'auto'),
           absolutePanel(id = 'panelSliderYear', class = "panel panel-default", 
                         draggable = TRUE, top = 10, right = 'auto', left = 60, 
                         bottom = 'auto', width = '100%', height = 'auto',
                         sliderInput('sliderYear', label = NULL,
                                              min = min(year.total$Year),
                                            max = max(year.total$Year), 
                                            value = max(year.total$Year),
                                     sep = '', step = 1L, width = 500
                                     ),
                         checkboxInput('checkSG', "Include Second Growth", value = TRUE),
                         actionButton('random', "new data"))
           )
    ))
  )
  
  
  

