observe({
  
  datafile <- values$file_filter
  col_onset <- input$value_onset
  
  req(datafile)
  req(col_onset)
  
  names(datafile)[names(datafile) == col_onset] <- "onset_date"
  
  date_length <- as.numeric(max(datafile$onset_date) - min(datafile$onset_date))
  
  if(date_length > 365*3){
    other_date_breaks <- '6 months'
    value_group <- 'month'
  }else if(date_length > 365){
    other_date_breaks <- '4 months'
    value_group <- 'month'
  }else if(date_length > 180){
    other_date_breaks <- 'month'
    value_group <- '7 days'
  }else if(date_length > 90){
    other_date_breaks <- '2 weeks'
    value_group <- '7 days'
  }else if(date_length > 30){
    other_date_breaks <- 'week'
    value_group <- 'day'
  }else{
    other_date_breaks <- 'day'
    value_group <- 'day'
  }
  
  updatePickerInput(session = session,
                    inputId = "other_date_breaks",
                    selected = other_date_breaks)
  updatePickerInput(session = session,
                    inputId = "value_group",
                    selected = value_group)
  
})