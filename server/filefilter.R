
data_table <- reactive(values$file_input)
data_name <- reactive(names(data_table()))
## set filter box
data_filter <- filter_data_server(
  id = "filter_data",
  data = reactive({
    req(data_table())
    req(names(data_table()))
    if(values$file_check){data_table()}
  })
)

observeEvent(values$file_check,{
  if(values$file_check){
    ## update value select
    updatePickerInput(session = session,
                      inputId = "value_onset",
                      selected = data_name()[grepl("日期|date|Date|发病|报告", data_name())][1],
                      choices = data_name())
    updatePickerInput(session = session,
                      inputId = "value_legend",
                      selected = data_name()[!grepl("日期|date|Date|发病|报告", data_name())][1],
                      choices = data_name())
  }
})

observeEvent(data_filter$filtered(),{
  values$file_filter <- data_filter$filtered()
  # print(as.data.frame(data_filter$filtered()))
})