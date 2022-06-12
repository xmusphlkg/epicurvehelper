
colors_manual <- reactiveValues(x = NULL)

output$color_manual <- renderUI({
  # value <- c('A', 'B', 'C', 'D')
  datafile <- values$file_input
  value_legend <- input$value_legend
  # print(datafile)
  if (is.null(value_legend)) value <- 'fill' else value <- sort(unique(datafile[,value_legend]), na.last = T)
  # value <- ifelse(is.null(value_legend), 'fill', sort(unique(datafile[,value_legend]), na.last = T))
  color_pal <- input$color_pal
  color_pal <- palettes[[color_pal]]
  if(input$color_pal_reverse) color_pal <- color_pal[rev(1:length(color_pal))]

  colors <- colorRampPalette(color_pal)(length(value))
  colors_id <- paste0("colors_", value)
  colors_manual$x <- setNames(as.list(colors_id), value)
  # browser()
  lapply(
    X = seq_along(value),
    FUN = function(i) {
      tagList(
        tags$span(
          tagAppendAttributes(
            colorPickr(
              inputId = colors_id[i],
              selected = colors[i],
              label = NULL,
              theme = "classic",
              useAsButton = TRUE,
              update = "save",
              interaction = list(
                hex = FALSE,
                rgba = FALSE,
                input = TRUE,
                save = TRUE,
                clear = FALSE
              )
            ),
            style = "display: inline; vertical-align: middle;"
          ),
          value[i]
        ),
        tags$br()
      )
    }
  )
})

outputOptions(output, "color_manual", suspendWhenHidden=FALSE)
