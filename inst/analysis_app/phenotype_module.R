# Phenotype module allows input of a phenotype definition
# and optional expression column.
# If `show_score` is true, add a "Score" checkbox.
# If `show_help` is true, add a help button.
phenotype_module_ui = function(id, values, show_score, show_help) {
  ns = shiny::NS(id)

  choices = setNames(c(NA, values), c('None', values))

  # Build the input row with optional help button
  input_row = list(
    shiny::column(5, shiny::textInput(ns("phenotype"), 'Phenotype:',
                                      placeholder='Phenotype definition')),
    shiny::column(5, shiny::selectInput(ns("expression"), 'Expression:',
                                        choices=choices,
                                        selected='None')))
  if (show_score)
    input_row = c(input_row, list(
      shiny::column(1, style='padding-top: 23px;',
                    shiny::checkboxInput(ns('score'), 'Score'))

    ))

  if (show_help)
    input_row = c(input_row, list(
      shiny::column(1, style='padding-top: 23px;',
        shiny::actionButton(ns('help'), '',
          style='border: none; background: transparent',
          icon=shiny::icon('question-circle-o', class='fa-2x')))

    ))

  shiny::tagList(shiny::fluidRow(shiny::tagList(input_row)),
    shiny::strong(shiny::textOutput(ns('error')),
                  style='color: maroon')
  )
}

phenotype_module = function(input, output, session, phenotypes, csd) {
  # Check for valid phenotype definitions
  observe({
    shiny::req(input$phenotype)
    output$error = renderText(
      phenoptr::validate_phenotype_definitions(input$phenotype, phenotypes, csd))
  })

  # Show help
  observeEvent(input$help, {
    shiny::req(input$help)
    shiny::showModal(
      shiny::modalDialog(
        shiny::p('Phenotype definitions are composed from the names of phenotypes. ',
                 'Definitions must end in + or -, for example CD3+ or CD8-.'),
        shiny::p('Individual phenotypes can be combined with slash (/) or comma (,).'),
        shiny::p('Combine with a slash to define double positive phenotypes, ',
                 'for example CD3+/CD8+.'),
        shiny::p('Combine with a comma to allow either phenotype, ',
                 'for example CD68+,CD163+.'),
        shiny::p('Phenotype definitions may also include valid expressions ',
                 'such as ',
                 shiny::code("~`Membrane PDL1 (Opal 520) Mean`>5",
                             style='color: black; background: #f5f5f5'),
                 '.'),
        shiny::p(shiny::a('Online Help',
                 href="https://akoyabio.github.io/phenoptrReports/articles/analysis.html")),
        title = 'Defining phenotypes',
        footer=NULL, easyClose = TRUE, fade = FALSE))
  })

  return(reactive({
    list(phenotype=input$phenotype,
         expression=input$expression,
         score=input$score)
  }))
}


phenotype_module_test = function() {
  choices = c('Nucleaus PDL-1 Mean', 'Membrane PDL-1 Mean')
  ui = shiny::fluidPage('Test',
                        shiny::wellPanel(
                          phenotype_module_ui('test1', choices, TRUE, TRUE),
                        shiny::br(),
                        phenotype_module_ui('test2', choices, FALSE, FALSE)),
                        shiny::p('Results',
                                  shiny::uiOutput('results'))
  )

  server = function(input, output, session) {
    available = c('CD3', 'CD8')
    the_data1 = shiny::callModule(phenotype_module, 'test1', available)
    the_data2 = shiny::callModule(phenotype_module, 'test2', available)

    observe({
      output$results = shiny::renderUI(
        shiny::HTML(paste(c(the_data1(), the_data2()), collapse='<br>')))
    })

    session$onSessionEnded(function() {
      shiny::stopApp()
    })
  }

  shiny::shinyApp(ui, server)
}

#shiny::runApp(phenotype_module_test())
