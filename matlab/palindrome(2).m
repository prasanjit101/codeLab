a=input("enter a number :");
temp=a;
i=0;
while(temp>0)
    i=i*10+mod(temp,10);
    temp=fix(temp/10);
end
if i==a
    disp('palindrome');
else
    disp('not a palindrome');
end