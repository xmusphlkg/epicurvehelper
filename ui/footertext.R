
# setting default ---------------------------------------------------------

get_labs_defaults <- function(name = c("title", "subtitle", "legend", "x", "y", "normal", "caption")) {
  name <- match.arg(name)
  defaults_labs <- list(
    title = list(size = 18, face = "bold", hjust = 0.5),
    subtitle = list(size = 16, face = "plain", hjust = 0.5),
    legend = list(size = 16, face = "bold", hjust = 0),
    x = list(size = 16, face = "bold", hjust = 0.5, angle = 0),
    y = list(size = 16, face = "bold", hjust = 0.5),
    normal = list(size = 14, face = "plain", hjust = 0.5),
    caption = list(size = 14, face = "plain", hjust = 0)
  )
  defaults_labs[[name]]
}


# setting function --------------------------------------------------------

labs_options_input <- function(inputId, defaults = list()) {
  dropMenu(
    actionButton(
      inputId = paste0(inputId, "_options"),
      label = '',
      icon = icon("plus"),
      style = 'position: absolute; right: 20px; border-radius: 0 0 0 0; margin-top: 5px'
    ),
    style = "width: 400px;",
    prettyRadioButtons(
      inputId = paste0(inputId, "_face"),
      label = "字体",
      choiceNames = c("正常", "斜体", "加粗", "斜体加粗"),
      choiceValues = c("plain", "italic", "bold", "bold.italic"),
      selected = defaults$face,
      status = "primary",
      inline = TRUE
    ),
    numericInput(
      inputId = paste0(inputId, "_size"),
      label = "字号",
      value = defaults$size
    ),
    awesomeRadio(
      inputId = paste0(inputId, "_align"),
      label = "对齐",
      choices = list(
        "左对齐" = '0', 
        "居中对齐" = '0.5', 
        "右对齐" ='1'
      ),
      selected = defaults$hjust,
      inline = TRUE,
      status = "success"
    ),
    if(inputId == 'text_legend') {
      radioGroupButtons(
        inputId = "text_legend_position",
        label = "图例位置",
        choiceNames = list(
          icon("arrow-left"),
          icon("arrow-up"),
          icon("arrow-down"),
          icon("arrow-right"),
          icon("ban")
        ),
        choiceValues = c("left", "top", "bottom", "right", "none"),
        selected = "right",
        justified = TRUE,
        size = "sm"
      )
    },
    placement = "right"
  )
}
