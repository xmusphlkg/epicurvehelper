library(shiny)

source('ui/footertext.R', encoding = 'UTF-8')
source('ui/footerpalette.R', encoding = 'UTF-8')
source('ui/footerpanel.R', encoding = 'UTF-8')
suppressMessages(source('ui/download.R', local = TRUE, encoding = 'utf-8'))

tagList(
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  dashboardPage(
    skin = 'black',
    title = 'EpicurveHelper',
    header = dashboardHeader(title = h4(HTML('流行曲线在线绘制<br/>(EpicurveHelper)')), 
                             titleWidth = 300,
                             tags$li(
                               class = 'dropdown',
                               style = "padding-top: 10px; padding-bottom: 5px; padding-right: 25px; color: #fff;",
                               actionButton(inputId = 'contact',
                                          label = '技术支持&问题反馈',
                                          icon = icon('question'),
                                          onclick ="location.href='mailto:fjmulkg@outlook.com'"),
                             includeHTML('ui/ui_components/googleanalytics.html')
                             )
                             ),
    sidebar = dashboardSidebar(width = 300, minified = FALSE,
                               sidebarMenu(
                                 tags$br(),
                                 HTML("<a href='https://www.ctmodelling.cn' target='_blank'>
                                      <img style = 'display: block; margin-left: auto; margin-right: auto;' 
                                      src='https://gitee.com/lkg1116/picture/raw/master/CTM.png' width = '50'></a>")
                               ),
                               fluidRow(
                                 column(width = 12,
                                        tags$b("Step1:"),
                                        includeHTML('ui/ui_components/file_load.html')),
                                 column(width = 12,
                                        conditionalPanel(condition = 'output.filetype',
                                                         selectInput(inputId = 'file_sheet_1',
                                                                     label = '选择工作簿',
                                                                     selected = NULL,
                                                                     choices = NULL,
                                                                     width = '100%')
                                        ),
                                        conditionalPanel(condition = 'output.fileUploaded',
                                                         actionButton(inputId = 'file_preview',
                                                                      label = '文件预览',
                                                                      icon = icon('binoculars'),
                                                                      width = '90%')
                                        )),
                                 hr(),
                                 conditionalPanel(condition = 'output.fileUploaded',
                                                  column(width = 12,
                                                         # tags$style(HTML('#sw-content-dropdown, .sw-dropdown-in {background-color: red;}')),
                                                         tags$b("Setp2:"),
                                                         dropMenu(
                                                           actionButton(
                                                             inputId = "show_examples",
                                                             label = '选择模板',
                                                             icon = icon("images"),
                                                             width = '90%'
                                                           ),
                                                           placement = 'right',
                                                           includeHTML('ui/ui_components/example_index_linux.html')
                                                         ),
                                                         tags$b("Setp3:"),
                                                         dropMenu(
                                                           actionButton(
                                                             inputId = "show_values",
                                                             label = '变量选择',
                                                             icon = icon("table"),
                                                             width = '90%'
                                                           ),
                                                           placement = 'right',
                                                           pickerInput(inputId = 'value_onset',
                                                                       label = '发病日期',
                                                                       selected = NULL,
                                                                       choices = NULL),
                                                           pickerInput(inputId = 'value_group',
                                                                       label = '病例汇总',
                                                                       selected = "每天",
                                                                       choices = list(
                                                                         "每天" = "day",
                                                                         "每2天" = "2 days",
                                                                         "每3天" = "3 days",
                                                                         "每4天" = "4 days",
                                                                         "每5天" = "5 days",
                                                                         "每6天" = "6 days",
                                                                         "每7天" = "7 days",
                                                                         "每10天" = "10 days",
                                                                         "每周" = "week",
                                                                         "每2周" = "2 weeks",
                                                                         "每月" = "month"
                                                                       )
                                                           ),
                                                           pickerInput(inputId = 'value_legend',
                                                                       label = '分组变量',
                                                                       selected = NULL,
                                                                       choices = NULL)
                                                         ),
                                                         tags$b("Setp4:"),
                                                         dropMenu(
                                                           actionButton(
                                                             inputId = "show_texts",
                                                             label = '增加文字',
                                                             icon = icon("language"),
                                                             width = '90%'
                                                           ),
                                                           placement = 'right',
                                                           tags$h3("Building")
                                                         )
                                                  )
                                 )
                               )
    ),
    footer = tags$footer(class='main-footer',
                         style = 'padding-top: 0px;padding-bottom: 0px;padding-right: 0px; padding-left: 0px;',
                         tags$style(type = 'text/css', ".bttn-fill.bttn-default{width: 100%; color:#333}"),
                         # tags$style(type = 'text/css', ".bttn-fill.bttn-helf{width: 50%; float:left}"),
                         footerpanel
    ),
    body = dashboardBody(
      disconnectMessage(
        text = "应用出错了，请刷新网页重试或者联系技术支持",
        refresh = "刷新",
        background = "#000000",
        colour = "#FFFFFF",
        refreshColour = "#337AB7",
        overlayColour = "#000000",
        overlayOpacity = 1,
        width = "full",
        top = "center",
        size = 24,
        css = ""
      ),
      tags$br(),
      ggplot_output('plot', height = '600px', downloads = download_bt)
    )
  )
)