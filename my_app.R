# Load the required libraries
library(shiny)
library(bslib)
library(shinyWidgets)
library(bsicons)
library(hover)


#Load the model
load("model_logistic.RData") 



# setting the background color
backgroundcolor<-setBackgroundColor(
  color = c("#fffff8","lightblue"),
  gradient = c("radial"),
  direction = c("buttom", "top", "right", "left"),
  shinydashboard = FALSE
)


# Define the UI for the application
ui <- page_sidebar(
                    backgroundcolor,
                    page_fluid(
                          titlePanel(title = h1(strong("Credit card default"),align = "center",style={" font-family: Montserrat;"}) )
                   ),
                   
                   sidebar = sidebar(
                              
                              bs_icon("bank2",size="12em"),
                              border=F ,
                              style = "background-color: lightblue;padding: 20px;",
                              bg="lightblue",
                              fg="white",
                              padding = "10px",
                              h4("Made by Dridi Slim",style={" font-family: Montserrat;position:absolute; bottom:120px;"}),
                              h4(htmlOutput("link1"),style={" font-family: Montserrat;position:absolute; bottom:80px;"}),
                              h4(htmlOutput("link2"),style={" font-family: Montserrat;position:absolute; bottom:30px;"})
                              
                      
                   ),
                   navset_card_underline(id="nav_list",
                     nav_panel("Introduction",
                               h2(strong("Welcome to our Credit Card Default Detection App!"),style={" font-family: Montserrat;"}),
                               h3("Are you concerned about credit card defaults impacting your financial stability? 
                                  Our app is designed to help you predict and mitigate these risks effectively. 
                                  Using advanced machine learning algorithms, 
                                  we analyze various factors to provide accurate predictions of potential credit card defaults.",style={" font-family: Montserrat;"}),
                                br(),
                               h3(strong("How It Works:"),style={" font-family: Montserrat;"}),
                               h3("1.Input Data: Fill out the form with client details and click Next.",style={" font-family: Montserrat;"}),
                               h3("2.Predict: Click Predict to get default predictions.",style={" font-family: Montserrat;"}),
                               h3("3.View Results: Check the results on the Results page.",style={" font-family: Montserrat;"}),
                               h3("4.Reset or Repeat: Clear data with Reset or input new data.",style={" font-family: Montserrat;"}),
                               br(),
                               column(width = 4,
                                      use_hover(),
                                        hover_action_button(
                                          "go",
                                          "Le's Go",
                                          icon = icon("arrow-right"),
                                          button_animation = "sweep-to-right",
                                          icon_animation = ""
                                        ))
                     ),
                     nav_panel("Client Data",
                     page_fluid(
                     fluidRow(
                       column(width = 12,
                              wellPanel(
                                fluidRow(
                                  column(width = 4,
                                         numericInput("LIMIT_BAL", "Credit Limit:", value = 5000, min = 0)),
                                  column(width = 4,
                                         numericInput("AGE", "Age:", value = 30, min = 21)),
                                  column(width = 4,
                                         numericInput("BILL_AMT6", "Bill Amount (Month 1):", value = 5000, min = 0))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         numericInput("BILL_AMT5", "Bill Amount (Month 2):", value = 5000, min = 0)),
                                  column(width = 4,
                                         numericInput("BILL_AMT4", "Bill Amount (Month 3):", value = 5000, min = 0)),
                                  column(width = 4,
                                         numericInput("BILL_AMT3", "Bill Amount (Month 4):", value = 5000, min = 0))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         numericInput("BILL_AMT2", "Bill Amount (Month 5):", value = 5000, min = 0)),
                                  column(width = 4,
                                         numericInput("BILL_AMT1", "Bill Amount (Month 6):", value = 5000, min = 0))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         numericInput("PAY_AMT6", "Payment Amount (Month 1):", value = 2000, min = 0)),
                                  column(width = 4,
                                         numericInput("PAY_AMT5", "Payment Amount (Month 2):", value = 2000, min = 0)),
                                  column(width = 4,
                                         numericInput("PAY_AMT4", "Payment Amount (Month 3):", value = 2000, min = 0))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         numericInput("PAY_AMT3", "Payment Amount (Month 4):", value = 2000, min = 0)),
                                  column(width = 4,
                                         numericInput("PAY_AMT2", "Payment Amount (Month 5):", value = 2000, min = 0)),
                                  column(width = 4,
                                         numericInput("PAY_AMT1", "Payment Amount (Month 6):", value = 2000, min = 0))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         selectInput("SEX", "Gender:", choices = c("Male", "Female"))),
                                  column(width = 4,
                                         selectInput("EDUCATION", "Education Level:", choices = c("Graduate School", "University", "High School", "Other"))),
                                  column(width = 4,
                                         selectInput("MARRIAGE", "Marital Status:", choices = c("Married", "Single")))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         selectInput("PAY_1", "Payment Status (Month 1):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months"))),
                                  column(width = 4,
                                         selectInput("PAY_2", "Payment Status (Month 2):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months"))),
                                  column(width = 4,
                                         selectInput("PAY_3", "Payment Status (Month 3):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months")))
                                ),
                                fluidRow(
                                  column(width = 4,
                                         selectInput("PAY_4", "Payment Status (Month 4):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months"))),
                                  column(width = 4,
                                         selectInput("PAY_5", "Payment Status (Month 5):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months"))),
                                  column(width = 4,
                                         selectInput("PAY_6", "Payment Status (Month 6):", choices = c("No payment", "Pay duly", "Payment on time", "Payment delay for one month", "Payment delay for two months", "Payment delay for three months", "Payment delay for four months", "Payment delay for five months", "Payment delay for six months", "Payment delay for seven months", "Payment delay for eight months")))
                                ),
                                fluidRow(
                                  column(width = 4,
                                                use_hover(),
                                                hover_action_button(
                                                  "predict_button",
                                                  "Predict",
                                                  icon = icon("brain"),
                                                  button_animation = "bounce-in",
                                                  icon_animation = ""
                                                ))
                            
                              )
                              )
                       )
                     )
                   )),
                   nav_panel("Result",
                             h3("Prediction Result:",style={" font-family: Montserrat;"}),
                             verbatimTextOutput("prediction_result"),
                             column(width = 4,
                                    use_hover(),
                                    hover_action_button(
                                      "reset_button",
                                      "Reset",
                                      icon = icon("refresh"),
                                      button_animation = "rotate",
                                      icon_animation = "spin"
                                    ))
                   )
                   
                   )
                   
                   
                   
                   
)


# Define the server logic
server <- function(input, output, session) {
  observeEvent(input$predict_button,{
    nav_select(
      "nav_list", selected = "Result" 
    )
                
               
               })
  observeEvent(input$predict_button, {
    # Prepare the input data for prediction
    input_data <- data.frame(
      LIMIT_BAL = as.factor(ifelse(input$LIMIT_BAL <= 81000, "0",
                                   ifelse(input$LIMIT_BAL <= 210000, "1", "2"))),
      AGE = as.factor(ifelse(input$AGE <= 30, "0",
                             ifelse(input$AGE <= 39, "1", "2"))),
      BILL_AMT1 = as.factor(ifelse(input$BILL_AMT1 <= 3558.75, "0",
                                   ifelse(input$BILL_AMT1 <= 22381.50, "1",
                                          ifelse(input$BILL_AMT1 <= 67091.00, "2", "3")))),
      BILL_AMT2 = as.factor(ifelse(input$BILL_AMT2 <= 2984.75, "0",
                                   ifelse(input$BILL_AMT2 <= 21200, "1",
                                          ifelse(input$BILL_AMT2 <= 64006.25, "2", "3")))),
      BILL_AMT3 = as.factor(ifelse(input$BILL_AMT3 <= 2666.25, "0",
                                   ifelse(input$BILL_AMT3 <= 20088.5, "1",
                                          ifelse(input$BILL_AMT3 <= 60164.75, "2", "3")))),
      BILL_AMT4 = as.factor(ifelse(input$BILL_AMT4 <= 2326.75, "0",
                                   ifelse(input$BILL_AMT4 <= 19052, "1",
                                          ifelse(input$BILL_AMT4 <= 54506, "2", "3")))),
      BILL_AMT5 = as.factor(ifelse(input$BILL_AMT5 <= 1763.0, "0",
                                   ifelse(input$BILL_AMT5 <= 18104.5, "1",
                                          ifelse(input$BILL_AMT5 <= 50190.5, "2", "3")))),
      BILL_AMT6 = as.factor(ifelse(input$BILL_AMT6 <= 1256.00, "0",
                                   ifelse(input$BILL_AMT6 <= 17071.00, "1",
                                          ifelse(input$BILL_AMT6 <= 49198.25, "2", "3")))),
      PAY_AMT1 = as.factor(ifelse(input$PAY_AMT1 <= 1428, "0",
                                  ifelse(input$PAY_AMT1 <= 3900, "1", "2"))),
      PAY_AMT2 = as.factor(ifelse(input$PAY_AMT2 <= 1300, "0",
                                  ifelse(input$PAY_AMT2 <= 3600, "1", "2"))),
      PAY_AMT3 = as.factor(ifelse(input$PAY_AMT3 <= 1000, "0",
                                  ifelse(input$PAY_AMT3 <= 3023, "1", "2"))),
      PAY_AMT4 = as.factor(ifelse(input$PAY_AMT4 <= 697.6667, "0",
                                  ifelse(input$PAY_AMT4 <= 3000, "1", "2"))),
      PAY_AMT5 = as.factor(ifelse(input$PAY_AMT5 <= 696, "0",
                                  ifelse(input$PAY_AMT5 <= 3000, "1", "2"))),
      PAY_AMT6 = as.factor(ifelse(input$PAY_AMT6 <= 613.6667, "0",
                                  ifelse(input$PAY_AMT6 <= 3000, "1", "2"))),
      SEX = as.factor(ifelse(input$SEX == "Male", "1", "2")), # Map Male to 0 and Female to 1
      EDUCATION = as.factor(ifelse(input$EDUCATION == "Graduate School", "1",
                                   ifelse(input$EDUCATION == "University", "2",
                                          ifelse(input$EDUCATION == "High School", "3", "4")))), # Map Education levels
      MARRIAGE = as.factor(ifelse(input$MARRIAGE == "Married", "1", "2")),
      PAY_1 = as.factor(ifelse(input$PAY_1 == "No payment", -2,
                               ifelse(input$PAY_1 == "Pay duly", -1,
                                      ifelse(input$PAY_1 == "Payment on time", 0,
                                             ifelse(input$PAY_1 == "Payment delay for one month", 1,
                                                    ifelse(input$PAY_1 == "Payment delay for two months", 2,
                                                           ifelse(input$PAY_1 == "Payment delay for three months", 3,
                                                                  ifelse(input$PAY_1 == "Payment delay for four months", 4,
                                                                         ifelse(input$PAY_1 == "Payment delay for five months", 5,
                                                                                ifelse(input$PAY_1 == "Payment delay for six months", 6,
                                                                                       ifelse(input$PAY_1 == "Payment delay for seven months", 7,
                                                                                              ifelse(input$PAY_1 == "Payment delay for eight months", 8)))))))))))),
    PAY_2 = as.factor(ifelse(input$PAY_2 == "No payment", -2,
                             ifelse(input$PAY_2 == "Pay duly", -1,
                                    ifelse(input$PAY_2 == "Payment on time", 0,
                                           ifelse(input$PAY_2 == "Payment delay for one month", 1,
                                                  ifelse(input$PAY_2 == "Payment delay for two months", 2,
                                                         ifelse(input$PAY_2 == "Payment delay for three months", 3,
                                                                ifelse(input$PAY_2 == "Payment delay for four months", 4,
                                                                       ifelse(input$PAY_2 == "Payment delay for five months", 5,
                                                                              ifelse(input$PAY_2 == "Payment delay for six months", 6,
                                                                                     ifelse(input$PAY_2 == "Payment delay for seven months", 7,
                                                                                            ifelse(input$PAY_2 == "Payment delay for eight months", 8)))))))))))),
  PAY_3 = as.factor(ifelse(input$PAY_3 == "No payment", -2,
                           ifelse(input$PAY_3 == "Pay duly", -1,
                                  ifelse(input$PAY_3 == "Payment on time", 0,
                                         ifelse(input$PAY_3 == "Payment delay for one month", 1,
                                                ifelse(input$PAY_3 == "Payment delay for two months", 2,
                                                       ifelse(input$PAY_3 == "Payment delay for three months", 3,
                                                              ifelse(input$PAY_3 == "Payment delay for four months", 4,
                                                                     ifelse(input$PAY_3 == "Payment delay for five months", 5,
                                                                            ifelse(input$PAY_3 == "Payment delay for six months", 6,
                                                                                   ifelse(input$PAY_3 == "Payment delay for seven months", 7,
                                                                                          ifelse(input$PAY_3 == "Payment delay for eight months", 8)))))))))))),
PAY_4 = as.factor(ifelse(input$PAY_4 == "No payment", -2,
                         ifelse(input$PAY_4 == "Pay duly", -1,
                                ifelse(input$PAY_4 == "Payment on time", 0,
                                       ifelse(input$PAY_4 == "Payment delay for one month", 1,
                                              ifelse(input$PAY_4 == "Payment delay for two months", 2,
                                                     ifelse(input$PAY_4 == "Payment delay for three months", 3,
                                                            ifelse(input$PAY_4 == "Payment delay for four months", 4,
                                                                   ifelse(input$PAY_4 == "Payment delay for five months", 5,
                                                                          ifelse(input$PAY_4 == "Payment delay for six months", 6,
                                                                                 ifelse(input$PAY_4 == "Payment delay for seven months", 7,
                                                                                        ifelse(input$PAY_4 == "Payment delay for eight months", 8)))))))))))),
PAY_5 = as.factor(ifelse(input$PAY_5 == "No payment", -2,
                         ifelse(input$PAY_5 == "Pay duly", -1,
                                ifelse(input$PAY_5 == "Payment on time", 0,
                                       ifelse(input$PAY_5 == "Payment delay for one month", 1,
                                              ifelse(input$PAY_5 == "Payment delay for two months", 2,
                                                     ifelse(input$PAY_5 == "Payment delay for three months", 3,
                                                            ifelse(input$PAY_5 == "Payment delay for four months", 4,
                                                                   ifelse(input$PAY_5 == "Payment delay for five months", 5,
                                                                          ifelse(input$PAY_5 == "Payment delay for six months", 6,
                                                                                 ifelse(input$PAY_5 == "Payment delay for seven months", 7,
                                                                                        ifelse(input$PAY_5 == "Payment delay for eight months", 8)))))))))))),
PAY_6 = as.factor(ifelse(input$PAY_6 == "No payment", -2,
                         ifelse(input$PAY_6 == "Pay duly", -1,
                                ifelse(input$PAY_6 == "Payment on time", 0,
                                       ifelse(input$PAY_6 == "Payment delay for one month", 1,
                                              ifelse(input$PAY_6 == "Payment delay for two months", 2,
                                                     ifelse(input$PAY_6 == "Payment delay for three months", 3,
                                                            ifelse(input$PAY_6 == "Payment delay for four months", 4,
                                                                   ifelse(input$PAY_6 == "Payment delay for five months", 5,
                                                                          ifelse(input$PAY_6 == "Payment delay for six months", 6,
                                                                                 ifelse(input$PAY_6 == "Payment delay for seven months", 7,
                                                                                        ifelse(input$PAY_6 == "Payment delay for eight months", 8))))))))))))
    
    )
    print(input_data)  # Print input data for debugging
    
    # Make prediction using the pre-trained model
    prediction <- predict(model_logistic, input_data, type = "response")
    print("predictionnn")
    print(prediction)
    
    # Display the prediction result
    output$prediction_result <- renderPrint({
      if(prediction >= 0.42) {
        "The model predicts default next month."
      } else {
        "The model predicts no default next month."
      }
    })
  })
  
  observeEvent(input$reset_button, {
    updateNumericInput(session, "LIMIT_BAL", value = 5000)
    updateNumericInput(session, "AGE", value = 30)
    updateNumericInput(session, "BILL_AMT1", value = 5000)
    updateNumericInput(session, "BILL_AMT2", value = 5000)
    updateNumericInput(session, "BILL_AMT3", value = 5000)
    updateNumericInput(session, "BILL_AMT4", value = 5000)
    updateNumericInput(session, "BILL_AMT5", value = 5000)
    updateNumericInput(session, "BILL_AMT6", value = 5000)
    updateNumericInput(session, "PAY_AMT1", value = 2000)
    updateNumericInput(session, "PAY_AMT2", value = 2000)
    updateNumericInput(session, "PAY_AMT3", value = 2000)
    updateNumericInput(session, "PAY_AMT4", value = 2000)
    updateNumericInput(session, "PAY_AMT5", value = 2000)
    updateNumericInput(session, "PAY_AMT6", value = 2000)
    updateSelectInput(session, "SEX", selected = "Male")
    updateSelectInput(session, "EDUCATION", selected = "Graduate School")
    updateSelectInput(session, "MARRIAGE", selected = "Married")
    updateSelectInput(session, "PAY_1", selected = "No payment")
    updateSelectInput(session, "PAY_2", selected = "No payment")
    updateSelectInput(session, "PAY_3", selected = "No payment")
    updateSelectInput(session, "PAY_4", selected = "No payment")
    updateSelectInput(session, "PAY_5", selected = "No payment")
    updateSelectInput(session, "PAY_6", selected = "No payment")
    
    # Update the prediction result text
    output$prediction_result <- renderPrint({ "Let's try again!!" })
  })
  observeEvent(input$reset_button, {
    nav_select(
      "nav_list", selected = "Client Data" 
        )
    })
  observeEvent(input$go, {
    nav_select(
      "nav_list", selected = "Client Data" 
    )
  })
  output$link1 <- renderUI({
    # Creating a text link
    a("Check out My linkdin", href = "https://www.linkedin.com/in/dridi-slim-415487291/")
  })
  output$link2 <- renderUI({
    # Creating a text link
    a("Check out My Github", href = "https://github.com/dridi1")
  })
}

# Run the application
shinyApp(ui = ui, server = server)

