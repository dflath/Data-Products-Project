library(shiny)

library(dplyr)
library(ggplot2)


load("./data/cps.rda")


# Define server logic required to plot 

shinyServer(function(input, output) {
        
        # Compute the forumla text in a reactive expression since it is
        # shared by the output$caption and output$wagePlot functions
        formulaText <- reactive({
                paste("Wage by ", input$category)
        })
        
        # Return the formula text for printing as a caption
        output$caption <- renderText({
                formulaText()
        })
        renderText({names(cps)})
        
        # output$test <- renderText({input$category})
        # Generate a boxplot of the requested variable against mpg and
        # only include outliers if requested
        output$wageBoxplot <- renderPlot({
                p <- ggplot(data = cps, aes_string(x = input$category , y = "Wage", fill = input$category)) + geom_boxplot() 
                p <- p  + labs(y = "Wage (dollars per hour)")  + coord_flip()
                print(p)
        })
        
        output$wageScatterplot <- renderPlot({
                p2 <- ggplot(data = cps,  aes_string(x = "Wage", col = input$category)) + geom_density() + labs(x= "Wage (dollars per hour)")
                print(p2)
        })
        
        output$wageSummary <- renderTable({
                mygroups <- substitute(group_by(cps, target), list(target = as.name(input$category)))
                mygroups <- eval(mygroups)
                summariz <- summarise(mygroups, Mean = mean(Wage), Median = median(Wage), Std_Deviation = sd(Wage))
                summariz
        })
})

# target <- "hp"

# call <- substitute(mutate(mtcars, scale(target)), list(target = 
                                                              # as.name(target))) 
# eval(call) 