
fib_len = ""
while fib_len == "":
    try: 
        fib_len = int(input("Please enter the length of the Fibonacci number: "))
        if fib_len < 0:
            print ("\nThe number should be greater or equal to zero!\n")
            fib_len = ""
    except:
        print("\nNo value was given!")
        print("The value must be an integer!\n")
    
fib_array = []
if fib_len == 0:
    print("\nYou have givin the value zero the length of the string. \n")
else:
    for fib_val in range(fib_len):
        if fib_val == 0 :
            fib_first = fib_val
            fib_array.append(fib_first)
        elif fib_val == 1:
            fib_second = fib_val
            fib_array.append(fib_second)
        elif fib_val == 2:
            fib_next = fib_first + fib_second
            fib_array.append(fib_next)
            fib_first = fib_next
        elif fib_val < 100:
            fib_next = fib_first + fib_second
            fib_array.append(fib_next)
            fib_second = fib_first
            fib_first = fib_next
        else:
            print("\nThe limit of the program is ", fib_val, " elements.\n")
            break
            
print("The length of the Fibonacci list is " + str(len(fib_array)) + " elements.\n")  
fib_list = [str(val) for val in fib_array]           
print(", ".join(fib_list))