clear;
x = 0:.1:2*pi;
y = sin(x);
plot(x,y,'b');
hold on

for i = 1:1:length(x)-1
    ah = annotation('arrow',...
            'headStyle','cback1',...
            'HeadLength',8,...
            'HeadWidth',5,...
            'Units','normalized');
    set(ah,'parent',gca);   
    set(ah,'position',[x(i) y(i) ...
        0.08*(x(i)-x(i+1)) 0.08*(y(i)-y(i+1)) ]);
    hold on
end