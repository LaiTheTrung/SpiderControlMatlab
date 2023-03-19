l1 = 25; l2 =30;
[X,Y,Z] = sphere;
scale = 15;
X=X*scale;
Y=Y*scale;
Z=Z*scale;
a = 30*pi/180;
C1x = scale*cos(a);  C1y = 25-scale*sin(a);   C1z = 15;
C2x = scale;         C2y = 25;                C2z = 15;
C3x = scale*cos(a);  C3y = 25+scale*sin(a);   C3z = 15;
C4x = -scale*cos(a); C4y = 25+scale*sin(a);   C4z = 15;
C5x = -scale;        C5y = 25;                C5z = 15;
C6x = -scale*cos(a); C6y = 25-scale*sin(a);   C6z = 15;

Cx =[C1x,C2x,C3x,C4x,C5x,C6x];
Cy =[C1y,C2y,C3y,C4y,C5y,C6y];
Cz =[C1z,C2z,C3z,C4z,C5z,C6z];

B1x = 2*scale*cos(a);  B1y = 25-scale*sin(a);    B1z = 0;
B2x = 2*scale;              B2y = 25;                 B2z = 0;
B3x = 2*scale*cos(a);  B3y = 25+scale*sin(a);    B3z = 0;
B4x = -2*scale*cos(a); B4y = 25+scale*sin(a);    B4z = 0;
B5x = -2*scale;             B5y = 25;                 B5z = 0;
B6x = -2*scale*cos(a); B6y = 25-scale*sin(a);    B6z = 0;

Bx =[B1x,B2x,B3x,B4x,B5x,B6x];
By =[B1y,B2y,B3y,B4y,B5y,B6y];
Bz =[B1z,B2z,B3z,B4z,B5z,B6z];

Ax =[0,0,0,0,0,0];
Ay =[0,0,0,0,0,0];
Az =[0,0,0,0,0,0];

for i=1:1:6
    [Ax(i),Ay(i),Az(i)] = leg(l1,l2,Cx(i),Cy(i),Cz(i),Bx(i),By(i),Bz(i));
end
%visualize
surf(X,Y+Cy(2),Z+Cz(2))
hold on;

for i=1:1:6
    plot3([Cx(i),Ax(i),Bx(i)], [Cy(i),Ay(i),By(i)], [Cz(i),Az(i),Bz(i)]);
    hold on;
end
axis([-40 40 0 300 0 50]);
set(gca, 'DataAspectRatio',[1 1 1]);
% each leg will move along a cycloid curve with radius  = r and the
% velocity of the spider is v
v =10;
r =2.5;
w = v/r;
T = 2*pi/w;
% time step:
dt = 0.05;
%total time
TimeTotal = 30;

step1=1;
step2=0;
step3=0;
time = 0;
for t = 0:dt:TimeTotal
    % the spider will move in 3 step:
    if (step1)
        for i = 1:1:6
           
        end
        for i = 1:1:6
            if (mod(i,2)==0)
                By(i) = By(i) +v *(1- cos(w*(t-time)))*dt;
                Bz(i) = Bz(i) + v*sin(w*(t-time))*dt;
            end 
        end
        for i=1:1:6
            [Ax(i),Ay(i),Az(i)] = leg(l1,l2,Cx(i),Cy(i),Cz(i),Bx(i),By(i),Bz(i));
        end
        if ((t-time)>=T)
            step1 =0;
            step2 =1;
            step3 =0;
            time = t;
        end
    end
    %---------------------------------------------------
    %step2
    if (step2)
        for i = 1:1:6
            Cy(i) = Cy(i)+v*dt;
        end
        for i = 1:1:6
            if (mod(i,2)==1)
                By(i) = By(i) + 2 *v *(1- cos(w*(t-time)))*dt;
                Bz(i) = Bz(i) + 2 * v * sin(w*(t-time))*dt;
            end 
        end
        for i=1:1:6
            [Ax(i),Ay(i),Az(i)] = leg(l1,l2,Cx(i),Cy(i),Cz(i),Bx(i),By(i),Bz(i));
        end
        if ((t-time)>=T)
            step1 =0;
            step2 =0;
            step3 =1;
            time = t;
        end
    end
    %---------------------------------------------------
    %step2
    if (step3)
        for i = 1:1:6
            Cy(i) = Cy(i)+v*dt;
        end
        for i = 1:1:6
            if (mod(i,2)==0)
                By(i) = By(i) + 2 * v *(1- cos(w*(t-time)))*dt;
                Bz(i) = Bz(i) + 2 * v*sin(w*(t-time))*dt;
            end 
        end
        for i=1:1:6
            [Ax(i),Ay(i),Az(i)] = leg(l1,l2,Cx(i),Cy(i),Cz(i),Bx(i),By(i),Bz(i));
        end
        if ((t-time)>=T)
            step1 =0;
            step2 =1;
            step3 =0;
            time = t;
        end
    end

    %redraw
    clf;
    surf(X,Y+Cy(2),Z+Cz(2))
    hold on;

    for i=1:1:6
        plot3([Cx(i),Ax(i),Bx(i)], [Cy(i),Ay(i),By(i)], [Cz(i),Az(i),Bz(i)]);
        hold on;
    end
    axis([-40 40 0 300 0 50]);
    set(gca, 'DataAspectRatio',[1 1 1]);
    pause(dt*0.1);
end

            
           
                
                
                
        

