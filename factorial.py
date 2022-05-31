fac_num = ""
while fac_num == "":
    try: 
        fac_num = int(input("Please enter the Factorial number that you what to be calculated: "))
        if fac_num < 0:
            print ("\nThe number should be greater or equal to zero!\n")
            fac_num = ""
    except:
        print("\nNo value was given!")
        print("The value must be an integer!\n")

fac_first = 1    
fac_array = []

for fac_val in range(fac_num + 1):
    if fac_val == 0:
        fac_second = fac_first
        fac_array.append(fac_second)
    elif fac_val < 100:
        fac_next = fac_second * fac_val
        fac_array.append(fac_next)
        fac_second = fac_next
    else:
        print("\nThe limit of the program is ", fac_val, " elements.\n")
        break

print("The factorial result of the number ", len(fac_array),".\n")
fac_rezult = fac_array[-1]
print(fac_rezult)