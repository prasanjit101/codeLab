num=0;
count=0;
while num<=0
    num=input('enter a positive number :');
end
for i=1:num-1
    if mod(num,i)==0
        count=count+1;
    end
    if count>1
        break;
    end
end
if count>1
    disp('The number entered is not a prime');
else
    disp('The number entered is prime');
end
