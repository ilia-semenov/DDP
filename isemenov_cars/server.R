library(shiny)


# Using the cars dataset (vehicle speed and corresponding stopping distance
# statistics), train a simple linearregression model. After the model selection
# process the regression through origin model dist=b*speed^2 was chosen:
# coefficient b is significant at 0% level, Adj. R-squared is 0.9025.

mod.lm<-lm(dist~I(speed^2)-1,data=cars)
dist_pred<-function (s) predict(mod.lm,data.frame(speed=s))


# Define server logic required to output stopping distance
shinyServer(function(input, output) {
        
        
        
        # Expression that generates output. renderText is used to
        # use reactivity feature (output changes once the input is changed).
        # Different output is generated for different metric systems.
                       
                
                output$speed_out <- renderText({                        
                        if (input$metric==1) {
                                paste("Car speed:", input$speed, " mph")
                        }
                        else{
                                paste("Car speed:", input$speed," kph")        
                        }
                })
                
                output$dist_out <- renderText({ 
                        if (input$metric==1) {
                                paste("<i>Predicted stopping distance:</i><b>",
                                      round(dist_pred(input$speed),digits=2), 
                                      " ft</b>")
                        }
                        else{
                                paste("<i>Predicted stopping distance:</i><b>", 
                                      round(dist_pred(input$speed/1.60934)*0.3048,
                                            digits=2)," m</b>")     
                        }
                })  
})

