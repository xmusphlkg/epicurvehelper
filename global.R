
options(shiny.usecairo = FALSE)

suppressPackageStartupMessages({
  library(shinydashboard)
  library(shinydashboardPlus)
  library(shinyalert)
  library(shinydisconnect)
  library(shinyWidgets)
  library(DT)
  # library(rhandsontable)
  library(datamods)
  library(esquisse)
  library(scales)
  
  library(tools, include.only = 'file_ext')
  library(openxlsx)
  # library(tidyverse)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(lubridate, include.only = 'floor_date')
  
  library(ggsci)
  library(Cairo)
  library(extrafont)
  
  library(rvg)
  library(officer)
  
  library(ggforce)
})


# source('server/font.R')
source('server/pals.R')
# source('server/packages/make_grate.R')

examples <- gsub('\\..*', '', list.files('ui/example/'))
