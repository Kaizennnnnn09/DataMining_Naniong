color = "green"
signal <- switch(color,
                 "red" = "Stop",
                 "yellow" = "Ready",
                 "green"= "Go",
                 "Invalid Signal")
print(signal)