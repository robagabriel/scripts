fac_first = 1
calc_limit = 997  
fac_num = ""

while fac_num == "":
    try: 
        fac_num = int(input("\nPlease enter the Factorial number that you what to be calculated: "))
        if fac_num < 0:
            print ("\nThe number should be greater or equal to zero!\n")
            fac_num = ""
    except:
        print("\nNo value was given!")
        print("The value must be an integer!\n")

def fac_function (val = 0):
    if val == 0:
        return fac_first
    else :
        return (val * fac_function(val - 1))

if fac_num < 998:
    print("\nThe result of the calculation " + str(fac_num) + "! is: " + str(fac_function(fac_num)) + "\n")
else:
    print("The limit was reached!\n" + str(calc_limit) + " is te maximum number that can be calculated!\n")
    