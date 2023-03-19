function [Ax,Ay,Az] = leg(l1,l2,Cx,Cy,Cz,Bx,By,Bz)
a0 = atan2((By-Cy),(Bx-Cx));
U = (Bx-Cx)/cos(a0);
K = Bz-Cz;
gama = atan2(K*l2,U*l1);
t1 = 0.5*(U^2 + K^2 + l1^2 - l2^2);
m1 = sqrt((U*l1)^2+(K*l2)^2);
a1PlusGama = asin(t1/m1);
if ((a1PlusGama<0)&&(t1>0))
    a1PlusGama = pi - a1PlusGama;
end
a1 = a1PlusGama - gama;

Ax = Cx + l1*sin(a1)*cos(a0);
Ay = Cy + l1*sin(a1)*sin(a0);
Az = Cz + l1*cos(a1);
end

