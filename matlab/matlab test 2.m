A=[3 1 2 3;2 -3 -1 -3;1 2 1 4];
D=A(:,1:3);
b=circshift(A,[0 1]);
Dx=b(:,1:3);
Dy=A;
Dy(:,2)=A(:,4);
Dz=A;
Dz(:,3)=A(:,4);
fprintf("x is %d",Dx/D);
fprintf("y is %d",Dy/D);
fprintf("y is %d",Dz/D);