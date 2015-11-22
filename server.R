
retire <- function(age=18, sav=as.numeric(0), inc, spd, int=4.0, tax = 15.0){
    history <- data.frame(age, sav, inc, spd, int_inc=sav*int/100)
    for(i in 2:(100-age)){
        age <- age + 1         
        sav <- sav*(1+int/100) + inc*(1-tax/100) - spd   
        
        history[i,] <- c(age,sav,inc=inc,spd=spd,int_income = sav*int/100)
        
        if(sav > spd/(int/100)) break
    }
    return(history) # was: age
}


retPlot <- function(fin, inc=0, spd=0){
    plot(fin$age, fin$sav, type="n", xlab="Your Age", ylab="Amount")
    
    lines(fin$age, fin$sav, col = "green", lwd = 3)
    lines(fin$age, fin$int_inc, col = "darkgreen", lwd = 5)
    abline(h=inc, lty = "dashed")  #### Not visible if savings > 0
    abline(h=spd, lty = "dotted")  #### Not visible if savings are > 0
    
    legend("topleft", 
           lty=c("solid","solid","dashed","dotted"), 
           col=c("green","darkgreen","black","black"), 
           lwd=c(3,5,1,1),
           legend=c("Savings","Interest Income","Salary","Spending")
    )
}



shinyServer(
    function(input, output){ 
        output$ret_age <- renderPrint({
            fin <- retire(
                    age=input$age,
                    sav=input$sav,
                    inc=input$inc,
                    spd=input$spd,
                    int=input$int,
                    tax=input$tax
            )
            print(fin[nrow(fin),1])
        })
        output$graph1 <- renderPlot({
            retPlot(retire(
                        age=input$age,
                        sav=input$sav,
                        inc=input$inc,
                        spd=input$spd,
                        int=input$int,
                        tax=input$tax ),
                    inc=input$inc, spd=input$spd)
        })
    }
)
      