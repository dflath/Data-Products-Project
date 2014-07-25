library(shiny)

shinyUI(fluidPage(
        titlePanel("US Wages 1985"),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("Visualize wages (dollars per hour) broken down by category"),
                        
                        selectInput(inputId = "category", 
                                    label = "Choose a category",
                                    choices = c("Sex", "Marital_Status", "Race", "Union_Membership"),
                                    selected = "Sex"),
                        
                        tableOutput(outputId = "wageSummary"),
                        
                        helpText(p(strong("This app"), "enables an exploratory data analysis of the US wage structure in 1985. 
                                   Select one of 4 categories to compare hourly wages of",  
                                   tags$ul(tags$li("males and females"),
                                   tags$li("married and single persons"), tags$li("whites and others"), 
                                   tags$li("union members and nonmembers")),"
                                   The app displays comparative summary statistics (mean, median, and standard deviation), density plots, and box and whisker plots."), 
                                   p("The box and whisker plots show:", 
                                   tags$ul(tags$li("first and third quartiles, the left and right box edges"), 
                                   tags$li("median, the vertical line in the box"),
                                   tags$li("interquartile range (iqr), the horizontal width of the box"),
                                   tags$li("whiskers, extending a distance 1.5 x iqr from the box edges or to the last data point, whichever is closest"),
                                   tags$li("outliers, the points beyond the whiskers"))),
                                   p("The data consists of 534 records extracted from the US Census Bureau's 1985 Current Population Survey."))
                ),
                
                mainPanel(
                        h3(textOutput(outputId = "caption")),
                        plotOutput(outputId = "wageScatterplot"), 
                        plotOutput(outputId = "wageBoxplot") 
                        
                )
        )
))