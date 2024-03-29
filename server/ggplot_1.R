#####################################
## @Descripttion: Not facet by select
## @version: 
## @Author: Li Kangguo
## @Date: 2022-04-20 20:32:17
## @LastEditors: Li Kangguo
## @LastEditTime: 2022-04-20 20:42:17
#####################################

if(col_legend != 'No'){ ## fill group
  ## classified by differ fill color --------------------------------------
  if(other_bar_border){
    # browser()
    ### show each cases in epicurve
    outbreak_plot <- outbreak_plot[rep(rownames(outbreak_plot), times = outbreak_plot$n),]
    ### avoid user input date and time
    outbreak_plot$bar <- as.Date(outbreak_plot$bar)
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {ggplot(data = outbreak_plot)+
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
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(scale_date_1, scale_date_2)))+
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
    
    ### do not show each cases
    outbreak_plot <- outbreak_plot %>% 
      ungroup() %>% 
      complete(
        bar = seq.Date(from = min(bar), to = max(bar), by = value_group), 
        group,
        fill = list(n = 0)
      )
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
    # browser()
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {ggplot(data = outbreak_plot)+
                        geom_col(mapping = aes(x = bar, y = 1),
                                 fill = group_color,
                                 color = other_bar_color,
                                 width = other_bar_width,
                                 size = other_bar_size,
                                 position = other_bar_position)+
                        scale_y_continuous(expand = expansion(mult = c(0, other_bar_expand)),
                                           labels = scale_y_text)+
                        scale_x_date(date_labels = other_date_format,
                                     date_breaks = other_date_breaks,
                                     expand = expansion(add = c(scale_date_1, scale_date_2)))+
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
    
    ### do not show each cases
    outbreak_plot <- outbreak_plot %>% 
      ungroup() %>% 
      complete(
        bar = seq.Date(from = min(bar), to = max(bar), by = value_group), 
        fill = list(n = 0)
      )
    # browser()
    suppressWarnings({
      render_ggplot(id = "plot", 
                    filename = 'epicurve_ctmodelling',
                    {ggplot(data = outbreak_plot)+
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
                                     expand = expansion(add = c(scale_date_1, scale_date_2)))+
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
}