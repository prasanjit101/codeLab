% from decimal to hexadecimal
n=input("enter value of n:");
a=[];
while n>0
    r=mod(n,16);
    a=[a r];
    n=fix(n/16);
end
for j=length(a):-1:1
    if a(j)<10
        a(j)=a(j)+48;
    else
        a(j)=a(j)+55;
    end
end
disp(char(a))

%{from hxadecimal to decimal}%

N=input("enter hexadecimal value as character:");
N=int8(N);
d=length(N);
decimal=0;
for k=length(N):-1:1
	if N(k)<65
		N(k)=N(k)-48;
	else
		N(k)=N(k)-55;
    end
    mul=16^(length(N)-k);
	decimal=decimal+N(k)*mul;
end
disp(decimal);