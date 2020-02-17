figure(1)
for k =0:0.06:0.5
   x=-k+6:0.01:k+6;
y1=sqrt(k^2-power(x-6,2));
y2=-sqrt(k^2-power(x-6,2));
plot(x,y2,'-r');
hold on
plot(x,y1,'-r');
axis equal
end
text(-7,-2,'\fontsize{10}正电荷');
text(6,-2,'\fontsize{10}负电荷');
for k =0:0.06:0.5
   x=-k-6:0.01:k-6;
y1=sqrt(k^2-power(x+6,2));
y2=-sqrt(k^2-power(x+6,2));
plot(x,y2,'-r');
hold on
plot(x,y1,'-r');
axis equal
end
for j =1:5
   x=-6:0.001:6;
y1=sqrt(j*j-power(x,2)*j*j/36);
y2=-sqrt(j*j-power(x,2)*j*j/36);
plot(x,y2,'-k','LineWidth',1);
hold on
plot(x,y1,'-k','LineWidth',1);
end
plot([-8,8],[0,0],'-r','LineWidth',1)
for X=-5:5
    ah = annotation('arrow',...
            'headStyle','cback1',...
            'HeadLength',8,...
            'HeadWidth',5,...
            'Units','normalized');
    set(ah,'parent',gca);   
    set(ah,'position',[0 X ...
        0.08*(0.1) 0 ]);
    hold on
end
quiver(0,0,9,0,'-r','LineWidth',1)
hold off
xlabel('x轴');
ylabel('y轴');
axis([-8,8,-8,8]);
grid on;
legend('电偶极子电场线')
title('电偶极子产生的电场_{by zhouyuchuan}')
