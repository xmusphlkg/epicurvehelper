#####################################
## @Description: load all script
## @version: 1.0
## @Author: Li Kangguo
## @Date: 2022-06-11 18:59:59
## @LastEditors: Li Kangguo
## @LastEditTime: 2022-09-13 08:24:26
#####################################
function(input, output, session) {
  values <- reactiveValues(
    file_input = NULL,
    file_check = F,
    file_load = NULL,
    file_raw = NULL,
    file_filter = NULL
  )

  source("server/color input.R", local = TRUE, encoding = "utf-8")
  source("server/fileinput.R", local = TRUE, encoding = "utf-8")
  source("server/filecheck.R", local = TRUE, encoding = "utf-8")
  source("server/filefilter.R", local = TRUE, encoding = "utf-8")
  source("server/ggplot.R", local = TRUE, encoding = "utf-8")
  source("server/examples.R", local = TRUE, encoding = "utf-8")
  source("server/example_update.R", local = TRUE, encoding = "utf-8")
}
