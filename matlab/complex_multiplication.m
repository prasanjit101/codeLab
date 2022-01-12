a=input("enter complex number 1:");
b=input("enter complex number 2:");
ar=real(a);
ai=imag(a);
br=real(b);
bi=imag(b);
disp(complex(ar*br-bi*ai,ai*br+ar*bi));