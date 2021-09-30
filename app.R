#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.


library("shiny")
library("shinyWidgets")
library("data.table")
library("DT")
library("here")

tabPanel.about <- source("R/about.R")$value

dt12 <- suppressWarnings({
    readRDS("data/proper_names.rds")
})
setkey(dt12, Category)

available_categories <- sort(unique(dt12$Category))
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Search Names"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            shinyWidgets::radioGroupButtons(
                inputId = "cateogry_input_select", 
                label = "Please Select", 
                choices = available_categories, 
                status = "primary"),
            
            shinyWidgets::searchInput(
                inputId = "search", label = "Search any column",
                placeholder = "",
                btnSearch = icon("search"),
                btnReset = icon("remove"),
                width = "350px"
            ),
            br(),

            br()
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
            tabPanel("Data",
                     DT::dataTableOutput("table1")
            ),
            tabPanel.about()
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$table1 <- DT::renderDT({
        in0 <- input$search
        dt_sub <- dt12[Category == input$cateogry_input_select & (Country %like% in0 | Name_EN %like% in0 | Name_CN %like% in0)]
        if(nrow(dt_sub>50))dt_sub <- dt_sub[1:50,]
        DT::datatable(dt_sub, options = list(pageLength = 15))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
