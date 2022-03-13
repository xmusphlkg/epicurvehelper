observeEvent(input$select_examples,{
  
  col_names <- names(values$file_input)
  print('example select')
  # example 1 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_1'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = T)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 1)
    updateColorPickr(session = session,
                     inputId = 'other_bar_color',
                     value = '#FFFFFF')
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0.3)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "stack")
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%m月\n%Y年")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_classic')
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 0)
    # updatePalettePicker(session = session,
    #                     inputId = "color_pal",
    #                     choices = choices,
    #                     selected = "Set1")
  }
  
  # example 2 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_2'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = F)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 1)
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "stack")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_bw')
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%Y/%m")
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 0)
  }
  
  # example 3 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_3'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = F)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 1)
    updateColorPickr(session = session,
                     inputId = 'other_bar_color',
                     value = '#000000')
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0.3)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "stack")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_gray')
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%Y年%m月")
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 0)
  }
  
  # example 4 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_4'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = F)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 1)
    updateColorPickr(session = session,
                     inputId = 'other_bar_color',
                     value = '#4B90B0')
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0.3)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "stack")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_minimal')
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%d日\n%m月")
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 0)
  }
  
  # example 5 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_5'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = F)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 1)
    updateColorPickr(session = session,
                     inputId = 'other_bar_color',
                     value = '#000000')
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0.2)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "stack")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_classic')
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%d")
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 0)
  }
  # example 6 ---------------------------------------------------------------
  
  if(input$select_examples == 'example_6'){
    updatePrettyCheckbox(session = session,
                         inputId = 'other_bar_border',
                         value = F)
    updateSliderInput(session = session,
                      inputId = 'other_bar_width',
                      value = 0.8)
    updateColorPickr(session = session,
                     inputId = 'other_bar_color',
                     value = '#000000')
    updateSliderInput(session = session,
                      inputId = 'other_bar_size',
                      value = 0)
    updateAwesomeRadio(session = session,
                       inputId = 'other_bar_position',
                       selected = "dodge")
    updatePickerInput(session = session,
                      inputId = 'color_theme',
                      selected = 'theme_light')
    updateSelectInput(session = session,
                      inputId = 'other_date_format',
                      selected = "%Y/%m/%d")
    updateNumericInput(session = session,
                       inputId = 'text_x_angle',
                       value = 90)
  }
})