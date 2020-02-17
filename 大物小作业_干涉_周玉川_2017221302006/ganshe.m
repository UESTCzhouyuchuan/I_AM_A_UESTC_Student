clc;
lam=500e-9;%输入波长
a=2e-3;D=1;
ym=5*lam*D/a;xs=ym;%设定光屏的范围
n=101;ys=linspace(-ym,ym,n);%把光屏的y方向分成101点
for i=1:n
    r1=sqrt((ys(i)-a/2).^2+D^2);
    r2=sqrt((ys(i)+a/2).^2+D^2);
    phi=2*pi*(r2-r1)/lam;
    B(i,:)=4*cos(phi/2).^2;
end
N=225;%确定用灰度等级为255级
Br=(B/4.0)*N;%使最大光强对应于最大灰度级（白色）
subplot(1,2,1)
image(xs,ys,Br);%面干涉条纹
title('干涉条纹_{带半波损失}')
colormap(gray(N));
%不带半波损失
subplot(1,2,2)
lam1=200e-9;%输入波长
a1=2e-3;D1=1;
ym1=5*lam1*D1/a1;xs1=ym1;%设定光屏的范围
n1=101;ys1=linspace(-ym1,ym1,n1);%把光屏的y方向分成101点
for i=1:n1
    r11=sqrt((ys1(i)-a1/2+0.3).^2+D1^2);
    r21=sqrt((ys1(i)+a1/2+0.3).^2+D1^2);
    phi1=2*pi*(r21-r11)/lam1;
    B1(i,:)=4*cos(phi1/2).^2;
end
N1=225;%确定用灰度等级为255级
Br1=(B1/4.0)*N1;%使最大光强对应于最大灰度级（白色）
subplot(1,2,2)
image(xs1,ys1,Br1);%面干涉条纹
title('干涉条纹_{不带半波损失}')
colormap(gray(N1));
figure(2)
plot(B,ys)%画出光强变化曲线
title('光强变化曲线_{by zhouyuchuan}')