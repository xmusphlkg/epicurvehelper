
observeEvent(values$file_raw,{
  
  data_table <- reactive(values$file_raw)
  data_name <- reactive(names(data_table()))
  
  if (length(data_name()) < 3 ){
    massage_title <- "变量过少"
    massage_type <- "error"
    massage_text <- "请核对变量数量，确保您的数据中至少有3列"
  } else {
    vars <- data_name()[grepl("日期|date|Date|发病|报告", data_name())]
    cols <- which(apply(mtcars, 2, is.numeric))
    if(length(vars) == 0){
      massage_title <- "变量名称识别失败"
      massage_type <- "error"
      massage_text <- "请核对变量数量，确保您的数据中至少有1列变量为日期，并且变量名称为“日期”或者“date”"
    } else if(length(cols) == 0){
      massage_title <- "变量名称识别失败"
      massage_type <- "error"
      massage_text <- "请核对变量数量，确保您的数据中至少有1列变量为数量，并且为阿拉伯数字"
    } else {
      massage_title <- "变量名称识别成功"
      massage_type <- "success"
      massage_text <- ""
      values$file_check <- T
    }
  }
  
  shinyalert(title = massage_title,
             type = massage_type,
             html = TRUE,
             text = massage_text
  )
})