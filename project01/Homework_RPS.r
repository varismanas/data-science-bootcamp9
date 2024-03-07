# User choice function
playGame <- function() {
  userScore <- 0
  computerScore <- 0

  getComputerChoice <- function() {
    choices <- c("rock", "paper", "scissors")
    randomIndex <- sample(1:3, 1)
    return(choices[randomIndex])
  }

  getUserChoice <- function() {
    cat("Please input (rock, paper, scissors, exit, or quit): ")
    choice <- tolower(readline())

    while (!(choice %in% c("rock", "paper", "scissors", "exit", "quit"))) {
      cat("Invalid input. Please enter rock, paper, scissors, exit, or quit: ")
      choice <- tolower(readline())
    }

    return(choice)
  }

  #find winner
  determineWinner <- function(userChoice, computerChoice) {
    if (userChoice == computerChoice) {
      return("not bad try again!")
    } else if ((userChoice == "rock" && computerChoice == "scissors") ||
               (userChoice == "paper" && computerChoice == "rock") ||
               (userChoice == "scissors" && computerChoice == "paper")) {
      return("Humen is every thing I'm winner!")
    } else {
      return("I am skynet I am winner!")
    }
  }

  ##start the game


  while (TRUE) {
    flush.console()
    cat("Current Score - You:", userScore, "Computer:", computerScore, "\n")

    userChoice <- getUserChoice()

    # Check for exit option
    if (userChoice %in% c("exit", "quit")) {
      cat("GGWP.\n")
      break
    }

    computerChoice <- getComputerChoice()

    cat("You choose:", userChoice, "\n")
    cat("Computer choose:", computerChoice, "\n")

    result <- determineWinner(userChoice, computerChoice)
    cat(result, "\n")

    if (result == "Humen is every thing I'm winner!") {
      userScore <- userScore + 1
    } else if (result == "I am skynet I am winner!") {
      computerScore <- computerScore + 1
    }

    cat("\n")
  }
}


