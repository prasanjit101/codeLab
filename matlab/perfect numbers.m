x=input('Enter no.');
num(x)
function num(x)
y=0;
for i=1:x-1
    if rem(x,i)==0
        y=y+i;
    end
end
if y==x
    disp('No. is prefect');
else
    disp('No. is not perfect');
end
end
