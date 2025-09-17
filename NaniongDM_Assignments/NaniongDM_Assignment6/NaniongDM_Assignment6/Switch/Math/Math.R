a = 5
b = 5
operation = 3
result <- switch(operation,
                 "1" = a + b,
                 "2" = a - b,
                 "3" = a * b,
                 "4" = a / b, "Invalid Operation"
)
print(result)