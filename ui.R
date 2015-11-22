library(shiny)

# First, write prediction function in R using local variables.



# Next, build a Shiny UI page.

shinyUI(pageWithSidebar(
    headerPanel("Retirement Calculator :-| :-( :-| :-)"),
    
    sidebarPanel(
        h3("Personal information"),
        numericInput("age", "What is your age?", 18, min=18, max=99, step=1),
        numericInput("spd", "What is your annual spending?",0,min=0),
        numericInput("inc", "What is your annual salary (pre-tax)?",0,min=0),
        numericInput("sav", "What is your total savings or bank balance?", 0,min=0),

        # How to enter break here?
        
        h3("Income and tax rates"),
        numericInput("int", "Real interest rate, %",4.0,min=0,max=10.0,step=0.5),
        numericInput("tax", "Income tax rate, %",15.0,min=0,max=100.0,step=1),
        
        submitButton('Submit')
        ),
            
    
    mainPanel(
        h3("How old will you be when you retire?"),
        p("This page calculates your expected age of retirement, and tracks your total
        savings over time, based on your current age, income, and spending.  It also
        takes into account external factors like the tax rate and interest rates."),
        p("Your 'retirement age' is the age it which your interest income, or savings
        * interest rates, is equal to or greater than your spending.  Enjoy!"),
        
        h4("Your age at retirement:"),
        verbatimTextOutput("ret_age"),
        
        h4("Your finances over time"),
        plotOutput("graph1")
        )   
))



