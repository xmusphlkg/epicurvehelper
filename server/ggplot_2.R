#####################################
## @Descripttion: facet by select
## @version: 
## @Author: Li Kangguo
## @Date: 2022-04-20 20:37:22
## @LastEditors: Li Kangguo
## @LastEditTime: 2022-04-20 20:42:50
#####################################

# browser()
if(!is.null(col_legend)){
  ## classified by differ fill color --------------------------------------
  if(other_bar_border){
    # browser()
    ### show each cases in epicurve
    outbreak_plot <- outbreak_plot[rep(rownames(outbreak_plot), times = outbreak_plot$n),]
    ### avoid user input date and time
    outbreak_plot$bar <- as.Date(outbreak_plot$bar)
    
    outbreak_plot$value <- 1
    outbreak_plot <- rbind(outbreak_plot,
                           data.frame(bar = seq.Date(from = as.Date(paste(lubridate::year(min(outbreak_plot$bar)), 1, 1, sep = '-')),
                                                     to = as.Date(paste(lubridate::year(max(outbreak_plot$bar)), 12, 31, sep = '-')),
                                                     by = value_group),
                                      n = 0,
                                      value = 0))
    if(other_date_facet == 'Year'){
      outbreak_plot$facet <- lubridate::year(outbreak_plot$bar)
    } else if(other_date_facet == 'Month'){
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
    } else if(other_date_facet == 'Quarter'){
      outbreak_plot$facet <- lubridate::quarter(outbreak_plot$bar)
    } else if(other_date_facet == 'Year-Month'){
      outbreak_plot$facet <- paste(lubridate::year(outbreak_plot$bar),
                                   lubridate::month(outbreak_plot$bar),
                                   sep = '-')
    } else {
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
      outbreak_plot$facet_1 <- lubridate::year(outbreak_plot$bar)
    }
    
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {fig <- ggplot(data = outbreak_plot)+
                        geom_col(mapping = aes(x = bar, y = value, fill = group),
                                 color = other_bar_color,
                                 width = other_bar_width,
                                 size = other_bar_size,
                                 position = other_bar_position)+
                        scale_fill_manual(values = group_color,
                                          na.value = colors_na)+
                        scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                                           labels = scale_y_text)+
                        scale_x_date(date_labels = other_date_format,
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(0, 0)))+
                        # coord_equal(ratio = date_length)+
                        theme_set()+
                        # theme(aspect.ratio = date_length)+
                        facet_wrap(.~ facet, scales = 'free_x', nrow = 1) +
                        labs(title = text_title,
                             subtitle = text_subtitle,
                             fill = text_legend,
                             x = text_xlabs,
                             y = text_ylabs,
                             caption = text_caption)
                    fig + ggforce::facet_row(vars(facet), scales = "free_x", space = "free", strip.position = 'bottom')
                    })
    })
  }else{
    
    ### do not show each cases
    outbreak_plot <- outbreak_plot %>% 
      ungroup() %>% 
      complete(
        bar = seq.Date(from = min(bar) - scale_date_1, to = max(bar) + scale_date_2, by = value_group), 
        group,
        fill = list(n = 0)
      )
    if(other_date_facet == 'Year'){
      outbreak_plot$facet <- lubridate::year(outbreak_plot$bar)
    } else if(other_date_facet == 'Month'){
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
    } else if(other_date_facet == 'Quarter'){
      outbreak_plot$facet <- lubridate::quarter(outbreak_plot$bar)
    } else if(other_date_facet == 'Year-Month'){
      outbreak_plot$facet <- paste(lubridate::year(outbreak_plot$bar),
                                   lubridate::month(outbreak_plot$bar),
                                   sep = '-')
    } else {
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
      outbreak_plot$facet_1 <- lubridate::year(outbreak_plot$bar)
    }
    # browser()
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {ggplot(data = outbreak_plot)+
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
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(scale_date_1, scale_date_2)))+
                        theme_set()+
                        facet_wrap(.~ facet, scales = 'free_x', nrow = 1) +
                        labs(title = text_title,
                             subtitle = text_subtitle,
                             fill = text_legend,
                             x = text_xlabs,
                             y = text_ylabs,
                             caption = text_caption)
                    })
    })
  }
} else {
  if(other_bar_border){
    ## not classified by differ fill color --------------------------------
    ### show each cases in epicurve
    outbreak_plot <- outbreak_plot[rep(rownames(outbreak_plot), times = outbreak_plot$n),]
    ### avoid user input date and time
    outbreak_plot$bar <- as.Date(outbreak_plot$bar)
    
    outbreak_plot$value <- 1
    
    outbreak_plot <- outbreak_plot |>
      ungroup() |>
      complete(
        bar = seq.Date(
          # from = min(bar) - scale_date_1,
          from = as.Date(paste(lubridate::year(min(bar)), 1, 1, sep = '-')),
          # to = max(bar) + scale_date_2,
          to = as.Date(paste(lubridate::year(max(bar)), 12, 31, sep = '-')),
          by = value_group
        ),
        fill = list(n = 0, value = 0)
      )
    # browser()
    if(other_date_facet == 'Year'){
      outbreak_plot$facet <- lubridate::year(outbreak_plot$bar)
    } else if(other_date_facet == 'Month'){
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
    } else if(other_date_facet == 'Quarter'){
      outbreak_plot$facet <- lubridate::quarter(outbreak_plot$bar)
    } else if(other_date_facet == 'Year-Month'){
      outbreak_plot$facet <- paste(lubridate::year(outbreak_plot$bar),
                                   lubridate::month(outbreak_plot$bar),
                                   sep = '-')
    } else {
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
      outbreak_plot$facet_1 <- lubridate::year(outbreak_plot$bar)
    }
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {fig <- ggplot(data = outbreak_plot)+
                        geom_col(mapping = aes(x = bar, y = value),
                                 fill = group_color,
                                 color = other_bar_color,
                                 width = other_bar_width,
                                 size = other_bar_size,
                                 position = other_bar_position)+
                        scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                                           labels = scale_y_text)+
                        scale_x_date(date_labels = other_date_format,
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(0, 0)))+
                        # coord_equal(ratio = date_length)+
                        theme_set()+
                        # theme(aspect.ratio = 2)+
                        # facet_wrap(.~ facet, scales = 'free_x', nrow = 1) +
                        labs(title = text_title,
                             subtitle = text_subtitle,
                             fill = text_legend,
                             x = text_xlabs,
                             y = text_ylabs,
                             caption = text_caption)
                    fig + ggforce::facet_row(vars(facet), scales = "free_x", space = "free", strip.position = 'bottom')
                    })
    })
  }else{
    # browser()
    ### do not show each cases
    outbreak_plot <- outbreak_plot %>% 
      ungroup() %>% 
      complete(
        bar = seq.Date(from = min(bar) - scale_date_1, to = max(bar) + scale_date_2, by = value_group), 
        fill = list(n = 0)
      )
    if(other_date_facet == 'Year'){
      outbreak_plot$facet <- lubridate::year(outbreak_plot$bar)
    } else if(other_date_facet == 'Month'){
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
    } else if(other_date_facet == 'Quarter'){
      outbreak_plot$facet <- lubridate::quarter(outbreak_plot$bar)
    } else if(other_date_facet == 'Year-Month'){
      outbreak_plot$facet <- paste(lubridate::year(outbreak_plot$bar),
                                   lubridate::month(outbreak_plot$bar),
                                   sep = '-')
    } else {
      outbreak_plot$facet <- lubridate::month(outbreak_plot$bar)
      outbreak_plot$facet_1 <- lubridate::year(outbreak_plot$bar)
    }
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {fig <- ggplot(data = outbreak_plot)+
                        geom_col(mapping = aes(x = bar, y = n),
                                 fill = group_color,
                                 color = other_bar_color,
                                 width = other_bar_width,
                                 size = other_bar_size,
                                 position = other_bar_position)+
                        scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                                           labels = scale_y_text)+
                        scale_x_date(date_labels = other_date_format,
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(0, 0)))+
                        theme_set()+
                        # facet_wrap(.~ facet, scales = 'free_x', nrow = 1, strip.position = 'bottom') +
                        labs(title = text_title,
                             subtitle = text_subtitle,
                             fill = text_legend,
                             x = text_xlabs,
                             y = text_ylabs,
                             caption = text_caption)
                    fig + ggforce::facet_row(vars(facet), scales = "free_x", space = "free", strip.position = 'bottom')
                    })
    })
  }
}