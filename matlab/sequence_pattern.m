n=input("enter value of n:");
sum=0;
for k=1:n
    sum=sum+((k^k)/factorial(k));
end
disp(sum);
