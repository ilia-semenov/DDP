library(shiny)

# Define UI for application
shinyUI(
        navbarPage("Cars: Speed vs. Stopping Distance",
                   tabPanel("Tool",
                            # Application title
                            titlePanel("Cars: Speed vs. Stopping Distance - Tool"),
                            # Sidebar with a checkbox for metric system choice as well as with
                            # numerical input box for vehicle speed input
                            sidebarLayout(
                                    sidebarPanel(
                                            radioButtons("metric", 
                                                         label = h3("Metric system"),
                                                         choices = list("US Standard (miles/feet)" = 1,
                                                                        "Metric" = 2),
                                             selected = 1),
                                            numericInput("speed",
                                                         label = h3("Speed"),
                                                         value = 1)
                                            ),
                                    # Show input speed value as well as predicted stopping distance
                                    mainPanel(
                                            h3("Results"),
                                            h4(htmlOutput("speed_out")),
                                            h4(htmlOutput("dist_out")),
                                            p("*Note the underlying model was trained on 
                                                data recorded in the 1920s.")
                                            )
                                    )
                            ),
                   tabPanel("Documentation",
                            fluidPage(
                                    
                                    titlePanel("Cars: Speed vs. Stopping Distance - Documentation"),
                                
                                    navlistPanel(                                            
                                            tabPanel("Overview",
                                                     h3("Cars: Speed vs. Stopping Distance - Overview"),
                                                     p("'Cars: Speed vs. Stopping Distance' is the tool 
                                                     developed for an assignment project within the 
                                                     'Developing Data Products' Coursera Course (
                                                     JHU Data Science Specialization) by Ilia 
                                                     Semenov."),
                                                     p("The project is intended to demonstrate the 
                                                       basic concepts of Shiny. The R tool developed for 
                                                       this demonstration represents a simple linear 
                                                       regression model trained on one of the datasets 
                                                       available in R - the Cars dataset."),
                                                     p("Basically, the idea is to create an interactive 
                                                       tool that provides an estimate of vehicle 
                                                       stopping distance given the speed input by user and 
                                                       adjusting results for the metric system chosen by 
                                                       user (miles or kilometers."),
                                                     p("For cimplicity, no complicated training models 
                                                       were used - just a simplele linear regression, 
                                                       which seems to fit the dataset with only one 
                                                       continuous target variable (dist - distance) and 
                                                       one predictor (speed)."),
                                                     p("After some model selection process, the final 
                                                       regression model was chosen as the best: 
                                                       distance=b*(speed)^2. this model has fully 
                                                       significant coefficient as well as high R-squared 
                                                       of 0.9025. Also, it is the regression through origin 
                                                       (no intercept) as we cannot have negative distances."),
                                                     p("The performance of the model was compared with other 
                                                       options, both simple and complex models (such as glmnet). 
                                                       It turns out that on the available dataset (50 observations 
                                                       only, the performance of simple linear regression in not 
                                                       significantly worse than the one of more complex models. 
                                                       For example, The mean RMSE for our LM (5-fold repeated 
                                                       CV was used for out-of-sample performance assessment) 
                                                       is 14.19 while glmnet (nested CV - 5-fold repeated 
                                                       CV for alpha and lambda grid search and -fold repeated 
                                                       CV for out-of-sample performance testing) gives 14.18."
                                                       ),
                                                     p("The metric system adjustment happens postfactum and does 
                                                       not appear in model training. Once the model is trained (
                                                       happens at the first page load), the predict function is 
                                                       called for the speed value inputted by user - if user chose 
                                                       miles no change is made to speed value (dataset is in US 
                                                       metric system), but if user chose km, the input speed is 
                                                       divided by 1.60934, and the output distance is multiplied 
                                                       by 0.3048 (ft to m)."
                                                       )
                                                     ),
                                            tabPanel("How To Use",
                                                     h3("Cars: Speed vs. Stopping Distance - How To Use"),
                                                     p("Using the tool is very simple - just go to the 
                                                       tool tab, choose the metric system and input the speed 
                                                       you want to get a stopping distance for. You will see 
                                                       the result at the right pane in bold.")
                                                     ),
                                            tabPanel("Dataset Documentation",
                                                     p("cars {datasets}"),
                                                     h4("R Documentation: Speed and Stopping Distances of Cars"),
                                                     h5("Description"),
                                                        p("The data give the speed of cars and the distances taken to stop.
                                                          Note that the data were recorded in the 1920s."),
                                                     h5("Format"),
                                                        p("A data frame with 50 observations on 2 variables.                                              
                                                        [,1]	 speed	 numeric	 Speed (mph)
                                                        [,2]	 dist	 numeric	 Stopping distance (ft)"),
                                                     h5("Source"),
                                                     p("Ezekiel, M. (1930) Methods of Correlation Analysis. Wiley."),
                                                     h5("References"),
                                                     p("McNeil, D. R. (1977) Interactive Data Analysis. Wiley.")),
                                            tabPanel("Author",
                                                     h4("Ilia Semenov, 2016"))
                                    )
                                )
                            )
        )
)

