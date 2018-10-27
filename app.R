library(shiny)
library(highcharter)
library(quantmod)

ui <- fluidPage(theme = "mycss.css",
  h1("App Demo Highcharter + quantmod"),
  fluidRow(
    column(width = 4, class = "panel",
           selectInput("x", label = "Type", width = "100%",
                       choices =  c(readRDS("www/stockSymbols.RDS"), # saveRDS(stockSymbols(),"stockSymbols.RDS")
                                    "BTC-USD","ETH-USD","LTC-USD","XRP-USD","ADA-USD", # extras
                                    "CIEL3F.SA","ITSA4.SA","PETR4.SA","BBDC4F.SA","PCAR4F.SA","ABEV3.SA","BVMF3.SA"))
           )
    ),
    column(width = 8,
           highchartOutput("hcontainer",height = "500px")
    )
  )

server = function(input, output) {
  
  output$hcontainer <- renderHighchart({

    
    getSymbols(input$x, auto.assign = FALSE) %>% 
      hchart
    
  })
  
}

shinyApp(ui = ui, server = server)
