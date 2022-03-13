
# file update -------------------------------------------------------------

observeEvent(input$file_input,{
  req(input$file_input)
  
  file <- input$file_input
  ext <- reactive({file_ext(input$file_input$datapath)})
  
  output$filetype <- reactive({
    return(ext() == 'xlsx')
  })
  
  outputOptions(output, 'filetype', suspendWhenHidden=FALSE)
  
  if(ext() == 'csv'){
    values$file_check <-  F
    values$file_filter <- NULL
    values$file_input <- read.csv(input$file_input$datapath, header = TRUE)
    values$file_raw <- values$file_input
    # removeUI(selector = "#xlsx_sheet_select")
    ext()
  } else if(ext() == 'xlsx'){
    # values$file_input <- read.xlsx(input$file_input$datapath, header = TRUE)
    file_xlsx <- getSheetNames(input$file_input$datapath)
    updateSelectInput(session = session,
                      inputId = 'file_sheet_1',
                      label = '选择工作簿',
                      selected = file_xlsx[1],
                      choices = file_xlsx)
    ext()
  } else {
    shinyalert(title = '输入格式错误',
               type = 'error',
               timer = 5000,
               HTML(paste0(
                 '平台仅支持csv和xlsx文件',
                 '您上传的是：', isolate(ext()),
                 '文件，请转换成受支持的文件格式后再试！'
               )))
    NULL
  }
})

observeEvent(input$file_sheet_1, ignoreInit = T, {
  values$file_check <-  F
  values$file_filter <- NULL
  values$file_input <- read.xlsx(input$file_input$datapath,
                                 sheet = input$file_sheet_1)
  values$file_raw <- values$file_input

  shinyalert(title = '格式问题',
             type = 'info',
             html = TRUE,
             text = tagList(
               '您上传的是：excel文件，请注意日期格式问题',
               tags$br(),
               tags$b('“数据预览”'),
               '中选择格式错误变量即可修正'
             )
             )
})


output$fileUploaded <- reactive({
  return(!is.null(values$file_raw))
})
outputOptions(output, 'fileUploaded', suspendWhenHidden=FALSE)

output$file_raw <- renderDT(values$file_input,
                            selection = 'none',
                            editable = "cell",
                            options = list(lengthChange = FALSE,
                                           language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Chinese.json'),
                                           dom = 'tp',
                                           scrollX = 400))


# file preview ------------------------------------------------------------

observeEvent(input$file_preview,{
  showModal(modalDialog(title = '文件预览',
                        size = 'xl',
                        footer = tagList(
                          actionButton(inputId = 'file_reset',
                                       label = '重置数据',
                                       icon = icon('trash')),
                          modalButton('确认修改')
                        ),
                        fluidRow(
                          column(width = 6,
                                 selectInput(inputId = 'file_row_date',
                                             label = HTML('
                                             <span style="float:left;">
                                             选择日期列
                                             </span>
                                             <span style="position: absolute; right:20px;">
                                             <i class="fa fa-exclamation"></i>
                                             <b>格式错误时选择</b>
                                             </span>'),
                                             choices = names(values$file_input),
                                             multiple = T)),
                          column(width = 6,
                                 selectInput(inputId = 'file_row_datetime',
                                             label = HTML('
                                             <span style="float:left;">
                                             选择日期时间列
                                             </span>
                                             <span style="position: absolute; right:20px;">
                                             <i class="fa fa-exclamation"></i>
                                             <b>格式错误时选择</b>
                                             </span>'),
                                             choices = names(values$file_input),
                                             multiple = T)),
                          column(width = 12,
                                 DTOutput('file_raw')),
                          column(width = 4,
                                 textInput(inputId = 'label_na',
                                           label = "缺失值标签",
                                           value = 'Missing',
                                           width = '300px'))
                        )))
})

# observeEvent(input$label_na,{
#   datafile <- values$input_file
#   datafile[is.na(datafile)] <- input$label_na
#   print(datafile[is.na(datafile)])
#   print(input$label_na)
#   values$input_file <- datafile
# })

observeEvent(input$file_reset,{
  values$file_input <- values$file_raw
  updateSelectInput(session = session,
                    inputId = 'file_row_datetime',
                    choices = names(values$file_input),
                    selected = NULL
                    )
  updateSelectInput(session = session,
                    inputId = 'file_row_date',
                    choices = names(values$file_input),
                    selected = NULL
  )
})

toListen <- reactive({
  list(input$file_row_datetime, input$file_row_date)
})
observeEvent(toListen(), ignoreInit = TRUE,{
  datafile <- values$file_input
  values$file_input <- datafile %>%
    mutate_at(input$file_row_datetime, convertToDateTime) %>%
    mutate_at(input$file_row_date, convertToDate)
})

observeEvent(input$file_raw_cell_edit,{
  values$file_input <- editData(values$file_input, input$file_raw_cell_edit, 'file_raw')
})

