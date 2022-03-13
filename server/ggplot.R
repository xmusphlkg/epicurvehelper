
# ggplot theme ------------------------------------------------------------

theme_set <- reactive({
  theme_input <- get(as.character(input$color_theme))
  theme_input()+
    # theme_classic()+
    theme(text = element_text(face = input$text_normal_face, 
                              size = input$text_normal_size,
                              hjust = as.numeric(input$text_normal_align)
          ),
          plot.title = element_text(face = input$text_title_face, 
                                    size = input$text_title_size,
                                    hjust = as.numeric(input$text_title_align)
          ),
          plot.subtitle = element_text(face = input$text_subtitle_face, 
                                       size = input$text_subtitle_size,
                                       hjust = as.numeric(input$text_subtitle_align)
          ),
          legend.title = element_text(face = input$text_legend_face, 
                                      size = input$text_legend_size,
                                      hjust = as.numeric(input$text_legend_align)
          ),
          axis.title.x = element_text(face = input$text_xlabs_face, 
                                      size = input$text_xlabs_size, 
                                      hjust = as.numeric(input$text_xlabs_align),
                                      vjust = 0
          ),
          axis.text.x = element_text(angle = input$text_x_angle),
          axis.title.y = element_text(face = input$text_y_face, 
                                      size = input$text_y_size, 
                                      hjust = as.numeric(input$text_ylabs_align)
          ),
          plot.caption = element_text(face = input$text_caption_face,
                                      size = input$text_caption_size,
                                      hjust = as.numeric(input$text_caption_align)
          ),
          legend.position = input$text_legend_position)
})

observe({
  ## rename datafile
  
  datafile <- values$file_filter
  col_onset <- input$value_onset
  value_group <- input$value_group
  
  req(datafile)
  req(col_onset)
  req(value_group)
  
  other_date_format <- input$other_date_format
  other_date_cluster <- input$other_date_cluster
  other_date_breaks <- input$other_date_breaks
  
  col_legend <- input$value_legend
  label_na <- input$label_na
  other_bar_border <- input$other_bar_border
  
  other_bar_position <- input$other_bar_position
  other_bar_border <- input$other_bar_border
  other_bar_color <- input$other_bar_color
  other_bar_size <- input$other_bar_size
  other_bar_width <- input$other_bar_width
  
  text_title <- input$text_title
  text_subtitle <- input$text_subtitle
  text_legend <- input$text_legend
  text_xlabs <- input$text_xlabs
  text_ylabs <- input$text_ylabs
  text_caption <- input$text_caption
  
  # datafile_plot <- datafile %>% 
  #   rename(c(
  #     "onset_date" = col_onset,
  #     "group" = col_legend
  #   )) %>% 
  #   mutate(onset_date = as.Date.POSIXct(onset_date))
  # filter(onset_date > as.Date('2017/01/01'))           ##test
  
  ## data setting
  datafile_plot <- datafile
  names(datafile_plot)[names(datafile_plot) == col_onset] <- "onset_date"
  names(datafile_plot)[names(datafile_plot) == col_legend] <- "group"
  if(is.numeric(datafile_plot$onset_date)) datafile_plot$onset_date <- convertToDate(datafile_plot$onset_date)
  
  ## color setting
  group_value <- sort(unique(datafile_plot$group), na.last = T)
  colors_id <- paste0("colors_", group_value)
  
  ## check color legend show
  if(is.null(input[[colors_id[1]]])){
    color_pal <- names(choices[[1]][1])
    color_pal <- palettes[[color_pal]]
    group_color <- colorRampPalette(color_pal)(length(group_value))
    colors_na <- "grey50"
  } else{
    group_color <- as.character(lapply(colors_id, FUN = function(x) {input[[x]]}))
    colors_na <- input[["colors_NA"]]
  }
  names(group_color) <- group_value
  
  ## y axis expand setting
  if(other_bar_position == 'fill'){
    other_bar_expand <- 0
    scale_y_text <- function(x) paste0(x*100, "%")
  } else {
    other_bar_expand <- 0.15
    scale_y_text <- waiver()
  }
  
  ## massage
  if(other_bar_border & other_bar_position != 'stack'){
    shinyalert(type = 'info',
               html = TRUE,
               text = tagList(
                 '您同时选择了：',
                 tags$br(),
                 tags$b('“图示每个病例”和“非堆积图”'),
                 tags$br(),
                 '请注意核对！',
                 tags$br(),
                 '我们不建议您这样子使用'
               ))
  }
  
  ## space between bars
  date_length <- as.numeric(seq.Date(from = Sys.Date(), length.out = 2, by = value_group)[2] - Sys.Date())
  other_bar_width <- other_bar_width * date_length

  # plot --------------------------------------------------------------------

  outbreak_plot <- datafile_plot %>% 
    mutate(bar = floor_date(onset_date, unit = value_group)) %>% 
    group_by(bar, group) %>% 
    count()
  
  # browser()
  if(other_bar_border){
    
    outbreak_plot <- outbreak_plot[rep(rownames(outbreak_plot), 
                                       times = outbreak_plot$n),]
    
    render_ggplot(id = "plot", 
                  filename = 'epicurve_ctmodelling',
                  {
      suppressWarnings({
        ggplot(data = outbreak_plot)+
          geom_col(mapping = aes(x = bar, y = 1, fill = group),
                   color = other_bar_color,
                   width = other_bar_width,
                   size = other_bar_size,
                   position = other_bar_position)+
          scale_fill_manual(values = group_color,
                            na.value = colors_na)+
          scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                             labels = scale_y_text)+
          scale_x_date(date_labels = other_date_format,
                       date_breaks = other_date_breaks)+
          coord_equal(ratio = date_length)+
          theme_set()+
          labs(title = text_title,
               subtitle = text_subtitle,
               fill = text_legend,
               x = text_xlabs,
               y = text_ylabs,
               caption = text_caption)
      })
    })
  }else{
    
    outbreak_plot <- outbreak_plot %>% 
      ungroup() %>% 
      complete(
        bar = seq.Date(from = min(bar),
                       to = max(bar),
                       by = value_group), 
        group,
        fill = list(n = 0)
      )
    # browser()
    render_ggplot(id = "plot", 
                  filename = 'epicurve_ctmodelling',
                  {
                    suppressWarnings({
                      ggplot(data = outbreak_plot)+
                        geom_col(mapping = aes(x = bar, y = n, fill = group),
                                 color = other_bar_color,
                                 width = other_bar_width,
                                 size = other_bar_size,
                                 position = other_bar_position)+
                        scale_fill_manual(values = group_color,
                                          na.value = colors_na)+
                        scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                                           labels = scale_y_text)+
                        scale_x_date(date_labels = other_date_format,
                                     date_breaks = other_date_breaks)+
                        theme_set()+
                        labs(title = text_title,
                             subtitle = text_subtitle,
                             fill = text_legend,
                             x = text_xlabs,
                             y = text_ylabs,
                             caption = text_caption)
                    })
                  })
  }
})
