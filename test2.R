library(DT)

ui <- fluidPage(
  DT::dataTableOutput("data_table", width = "100%")
)

server <- function(input, output, session) {
  output$data_table <- DT::renderDataTable(server = FALSE,
                                           DT::datatable(
                                             data = iris,
                                             extensions = c("Buttons", "ColReorder", "FixedHeader"),
                                             options = list(
                                               buttons = c("copy", "csv", "excel", "pdf", "print"),
                                               dom = "lBrtip",
                                               colReorder = TRUE,
                                               fixedHeader = TRUE,
                                               searching = FALSE,
                                               pageLength = 30,
                                               lengthMenu = c(5, 15, 25, 50, 100),
                                               scrollX = TRUE
                                             )
                                           )
  )
}

shinyApp(ui, server)