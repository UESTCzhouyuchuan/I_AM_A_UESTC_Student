figure(1)
for i =0:0.04:1
   x=-i:0.01:i;
y1=sqrt(i^2-power(x,2));
y2=-sqrt(i^2-power(x,2));
plot(x,y2,'-r');
hold on
plot(x,y1,'-r');
end
for i =2:5
   x=-i:0.001:i;
y1=sqrt(i^2-power(x,2));
y2=-sqrt(i^2-power(x,2));
plot(x,y2,'-k','LineWidth',1);
hold on
plot(x,y1,'-k','LineWidth',1);
end
x=-6:6;
y=-6:6;
y1=x;
y2=-x;
plot(x,y1,'-r','LineWidth',1)
plot(x,y2,'-r','LineWidth',1);
plot([0,0],[-6,6],'-r','LineWidth',1)
plot([-8,8],[0,0],'-r','LineWidth',1)
quiver(0,0,0,6,'-r','LineWidth',1)
quiver(0,0,0,-6,'-r','LineWidth',1)
quiver(0,0,5,5,'-r','LineWidth',1)
quiver(0,0,-5,-5,'-r','LineWidth',1)
quiver(0,0,-5,5,'-r','LineWidth',1)
quiver(0,0,5,-5,'-r','LineWidth',1)
quiver(0,0,6,0,'-r','LineWidth',1)
quiver(0,0,-6,0,'-r','LineWidth',1)
xlabel('x轴');
ylabel('y轴');
axis([-6,6,-6,6]);
axis equal
grid on;
legend('电荷电场线')
title('电荷产生的电场_{by zhouyuchuan}')
