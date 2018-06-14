library(shiny)
library(shinyjs)
library(rdrop2)
library(dplyr)
library(readr)
library(sf)
library(lubridate)
library(magrittr)
library(leaflet)
library(poisspatial)
library(slackr)
library(purrr)
library(lwgeom)
library(jsonlite)

### auth

#slackr
slackr::slackr_setup(config_file = "./.slackr")

### --- objects
mapbox_url <- "https://api.mapbox.com/styles/v1/sebpoisson/cjib5soqe8okk2rpheo0btduf/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic2VicG9pc3NvbiIsImEiOiJjamk1YXBiYm4waHd0M2twNmM3ODRuZjN4In0.WKHsGJ3K7SWyqO4lObCkfA
"

logged <- readRDS('input/logged.rds') 
centroid <- readRDS('input/centroid.rds')
year.total <- read_csv('input/year_totals.csv')

### --- functions
create_error <- function(message, header = "random") {
  showModal(modalDialog(
    footer = modalButton("Got it"),
    title = ifelse(header == "random", sample(messages, 1), header),
    message
  ))
}

file_ext <- function(x) {
  x %>%
    strsplit(".", fixed = TRUE) %>%
    unlist %>%
    extract(1)
}

selectizeInputX <- function(...) {
  selectizeInput(..., multiple = TRUE, options = list(
    'plugins' = list('remove_button'),
    'create' = TRUE,
    'persist' = FALSE))
}  

label_mandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

addLegendCustom <- function(map, colors, labels, sizes, opacity = 1,
                            title = NULL, layerId = 'legendCustom', position = 'bottomleft'){
  colorAdditions <- paste0(colors, "; width:", sizes, "px; height:", sizes, "px")
  labelAdditions <- paste0("<div style='display: inline-block;height: ", sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", labels, "</div>")
  
  return(addLegend(map, colors = colorAdditions, labels = labelAdditions, 
                   opacity = opacity, position = position, title = title,
                   layerId = layerId))
}

