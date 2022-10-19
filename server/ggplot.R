#####################################
## @Descripttion: main plot server
## @version: 1.2
## @Author: Li Kangguo
## @Date: 2022-03-23 20:27:31
## @LastEditors: Li Kangguo
## @LastEditTime: 2022-10-19 12:12:27
#####################################

# ggplot theme ------------------------------------------------------------

theme_set <- reactive({
  theme_input <- get(as.character(input$color_theme))
  theme_input() +
    # theme_classic()+
    theme(
      text = element_text(
        face = input$text_normal_face,
        size = input$text_normal_size,
        hjust = as.numeric(input$text_normal_align)
      ),
      plot.title = element_text(
        face = input$text_title_face,
        size = input$text_title_size,
        hjust = as.numeric(input$text_title_align)
      ),
      plot.subtitle = element_text(
        face = input$text_subtitle_face,
        size = input$text_subtitle_size,
        hjust = as.numeric(input$text_subtitle_align)
      ),
      legend.title = element_text(
        face = input$text_legend_face,
        size = input$text_legend_size,
        hjust = as.numeric(input$text_legend_align)
      ),
      axis.title.x = element_text(
        face = input$text_xlabs_face,
        size = input$text_xlabs_size,
        hjust = as.numeric(input$text_xlabs_align),
        vjust = 0
      ),
      axis.text.x = element_text(angle = input$text_x_angle),
      axis.title.y = element_text(
        face = input$text_y_face,
        size = input$text_y_size,
        hjust = as.numeric(input$text_ylabs_align)
      ),
      plot.caption = element_text(
        face = input$text_caption_face,
        size = input$text_caption_size,
        hjust = as.numeric(input$text_caption_align)
      ),
      legend.position = input$text_legend_position,
      strip.placement = "outside",
      strip.background.x = element_blank(),
      strip.text.x = element_text(
        face = input$text_xlabs_face,
        size = input$text_xlabs_size,
        hjust = as.numeric(input$text_xlabs_align),
        vjust = 0
      ),
      plot.margin = margin(5, 20, 5, 5)
    )
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
  col_weight <- input$value_weight
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

  scale_date_1 <- input$scale_date_1
  scale_date_2 <- input$scale_date_2
  other_date_facet <- input$other_date_facet

  # datafile_plot <- datafile %>%
  #   rename(c(
  #     "onset_date" = col_onset,
  #     "group" = col_legend
  #   )) %>%
  #   mutate(onset_date = as.Date.POSIXct(onset_date))
  # filter(onset_date > as.Date('2017/01/01'))           ##test


  ## y axis expand setting
  if (other_bar_position == "fill") {
    other_bar_expand <- 0
    scale_y_text <- function(x) paste0(x * 100, "%")
  } else {
    other_bar_expand <- 0.15
    scale_y_text <- waiver()
  }

  ## massage
  if (other_bar_border & other_bar_position != "stack") {
    shinyalert(
      type = "info",
      html = TRUE,
      text = tagList(
        "您同时选择了：",
        tags$br(),
        tags$b("“图示每个病例”和“非堆积图”"),
        tags$br(),
        "请注意核对！",
        tags$br(),
        "我们不建议您这样使用"
      )
    )
  }

  ## data setting
  datafile_plot <- datafile
  names(datafile_plot)[names(datafile_plot) == col_onset] <- "onset_date"
  if (is.numeric(datafile_plot$onset_date)) datafile_plot$onset_date <- convertToDate(datafile_plot$onset_date)

  ## data weighting
  if (!is.null(col_weight) & col_weight != "No") {
    datafile_plot$weight <- datafile_plot[, col_weight]
    if (is.numeric(datafile_plot$weight)) {
      # browser()
      datafile_plot <- datafile_plot[rep(rownames(datafile_plot), times = round(datafile_plot$weight)), -ncol(datafile_plot)]
    } else {
        shinyalert(
          type = "error",
          timer = 5000,
          HTML("加权变量为非整数，请修改核对后再次尝试")
        )
    }
  }

  # browser()
  if (!is.null(col_legend)) {
    if (col_legend == 'No') {
      datafile_plot$group <- 'a'
    } else {
      names(datafile_plot)[names(datafile_plot) == col_legend] <- "group"
    }
    datafile_plot$group <- as.factor(datafile_plot$group)

    ## color setting
    group_value <- sort(unique(datafile_plot$group), na.last = T)
    colors_id <- paste0("colors_", group_value)

    ## check color legend show
    if (is.null(input[[colors_id[1]]])) {
      color_pal <- names(choices[[1]][1])
      color_pal <- palettes[[color_pal]]
      group_color <- colorRampPalette(color_pal)(length(group_value))
      colors_na <- "grey50"
    } else {
      group_color <- as.character(lapply(colors_id, FUN = function(x) {
        input[[x]]
      }))
      colors_na <- input[["colors_NA"]]
    }
    names(group_color) <- group_value

    outbreak_plot <- datafile_plot %>%
      mutate(bar = floor_date(onset_date, unit = value_group)) %>%
      group_by(bar, group) %>%
      count()
  } else {
    outbreak_plot <- datafile_plot %>%
      mutate(bar = floor_date(onset_date, unit = value_group)) %>%
      group_by(bar) %>%
      count()
    group_color <- input$colors_fill
  }

  ## space between bars
  date_length <- as.numeric(seq.Date(from = Sys.Date(), length.out = 2, by = value_group)[2] - Sys.Date())
  other_bar_width <- other_bar_width * date_length
  # browser()

  # plot --------------------------------------------------------------------
  if (other_date_facet == "No") {
    # browser()
    source("server/ggplot_1.R", local = T)
  } else {
    # browser()
    source("server/ggplot_2.R", local = T)
  }
})