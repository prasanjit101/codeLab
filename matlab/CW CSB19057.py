import math
import numpy as np
X=math.pi
t=int(input("Enter n :"))
def series(n):
    sum=0
    for i in range(1,n+1):
        sum=sum+(X**i)/np.sqrt(i)
        print("PI^{}/sqrt({})".format(i,i),end="")
        if i<n:
            print("+",end="")
        else:
            print("=",end="")
    return sum
print(series(t))

# CSB19057
# PRASANJIT DUTTA