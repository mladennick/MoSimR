%%
[X,Y,Z] = plot_ws_2D_viste(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,100,1);
figure;
plot(X,Y)
grid on
title('Vista XZ normativa UNI ISO 29946')
xlabel('Z1')
ylabel('X1')
axis equal
ylim([-2 2])

hold on
plot(0,0,'LineWidth',1.3,'Marker','>','Color','r');
plot([0 a],[0 0],'LineWidth',1.3,'Color','r');
plot(a,0,'LineWidth',1.3,'Marker','o','Color','r');
plot([a a+b],[0 0],'LineWidth',1.3,'Color','r');
plot(a+b,0,'LineWidth',1.3,'Marker','o','Color','r');
plot([a+b a+b+c+maxQ2/2],[0 0],'LineWidth',1.3,'Color','r');
plot(a+b+c+maxQ2/2,0,'LineWidth',1.3,'Marker','o','Color','r');
plot([a+b+c+maxQ2/2 a+b+c+maxQ2/2],[0 d],'LineWidth',1.3,'Color','r');
plot(a+b+c+maxQ2/2,d,'LineWidth',1.3,'Marker','o','Color','r');

%%
[X,Y,Z] = plot_ws_2D_viste(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,100,2);
figure;
plot(Z,Y)
grid on
title('Vista XY normativa UNI ISO 29946')
xlabel('Y1')
ylabel('X1')
axis equal
ylim([-2 2])


hold on
plot(0,0,'LineWidth',1.3,'Marker','o','Color','r');
plot(0,0,'LineWidth',1.3,'Marker','x','Color','r');
plot([0 0],[0 d],'LineWidth',1.3,'Color','r');
plot(0,d,'LineWidth',1.3,'Marker','o','Color','r');