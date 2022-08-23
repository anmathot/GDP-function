require(shiny)

require(ggplot2)
theme_set(theme_minimal())
require(latex2exp) 
data <- read.csv(file = "Data.csv", header = TRUE, sep = "\t",dec =",",row.names =1)

Nombre = c(1:267)
Pays = c(row.names(data))
Data1 <- data.frame(x = Nombre, y = Pays)

ui <- fluidPage(
  titlePanel("Country fct"),   
  br(),                          
  sliderInput(
    inputId = "nbr",               
    label = "Choose a country",    
    value = 18,  
    min = 1,
    max = 267,
    step = 1        
  ),
  plotOutput("Plot")         
)

server <- function(input, output) {         
  output$Plot <- renderPlot({
    nbre <- input$nbr
    Frame <- data.frame(x = c(as.numeric(data[267,1:62])), y = c(as.numeric(data[nbre, 1:62])))
    ggplot(data = Frame, aes(x = x, y = y)) + 
      geom_line(color = "red")+
      labs(title = paste('Evolution of the gdp of',Data1[nbre,2], '.'), y = "GDP",x = "Years")
    })
}
shinyApp(ui = ui, server = server)        
