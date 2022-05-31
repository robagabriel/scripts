fib_empty = ""
fib_array = []
fib_len = ""
while fib_len == "":
    try: 
        fib_len = int(input("\nPlease enter the length of the Fibonacci number: "))
        if fib_len < 0:
            print ("\nThe number should be greater or equal to zero!\n")
            fib_len = ""
    except:
        print("\nNo value was given!")
        print("The value must be an integer!\n")


def fib_function(val):
    if val in {0, 1}:
        return val
    else:
        return fib_function(val - 1) + fib_function(val - 2)

if fib_len == 0:
    fib_empty = "The list can have zero elemets"
elif fib_len < 36:
    for fib_val in range(fib_len):
        fib_array.append(fib_function(fib_val))
else:
    print("\nThe limit of the script is 35!\n")

if fib_empty == "The list can have zero elemets":
    print(fib_empty)
elif fib_len < 36:
    print("\nThe length of the Fibonacci list is " + str(len(fib_array)) + " elements.\n")  
    fib_list = [str(val) for val in fib_array]           
    print(", ".join(fib_list) + "\n")



