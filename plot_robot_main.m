function plotRPR(Q,L,colore)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%figure(fig) % fig figure number
q1 = Q(1);
q2 = Q(2);
q3 = Q(3);
a = L(1);
b = L(2);
c = L(3);
d = L(4);

x1 = 0;
y1 = 0;
z1 = 0;

x2 = a;
y2 = 0;
z2 = 0;

x3 = a+b*cos(Q(1));
y3 = 0;
z3 = b*sin(Q(1));

x4 = a+(b+Q(2))*cos(Q(1));
y4 = 0;
z4 = (b+Q(2))*sin(Q(1));

x5 = a+(b+Q(2)+c)*cos(Q(1));
y5 = 0;
z5 = (b+Q(2)+c)*sin(Q(1));

x6 = a+(b+Q(2)+c)*cos(Q(1))-d*cos(Q(3))*sin(Q(1));
y6 = d*sin(Q(3));
z6 = (b+Q(2)+c)*sin(Q(1))+d*cos(Q(3))*cos(Q(1));

if abs(x6) <= 1e-16
    x6 = 0;
end

if abs(y6) <= 1e-16
    y6 = 0;
end

if abs(z6) <= 1e-16
    z6 = 0;
end

hold on
plot3([x1 x2 x3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],[z1 z2 z3 z4 z5 z6], 'LineWidth',2,'color',colore); %manipulator
plot3([x2 x3 x4],[y2 y3 y4],[z2 z3 z4], 'o','color',colore); %joint position
axis equal
grid on
ax = gca;
ax.YAxis.Direction = 'reverse';
xlabel('x [m]')
ylabel('z [m]')
zlabel('y [m]')



end

