clc;
lam=200e-9;%输入波长
a=2e-3;D=1;
ym=5*lam*D/a;xs=ym;%设定光屏的范围
n=101;ys=linspace(-ym,ym,n);%把光屏的y方向分成101点
for i=1:n
    r1=sqrt((ys(i)-a/2+0.3).^2+D^2);
    r2=sqrt((ys(i)+a/2+0.3).^2+D^2);
    phi=2*pi*(r2-r1)/lam;
    B(i,:)=4*cos(phi/2).^2;
end
N=225;%确定用灰度等级为255级
Br=(B/4.0)*N;%使最大光强对应于最大灰度级（白色）
subplot(1,1,1)
image(xs,ys,Br);%面干涉条纹
title('干涉条纹_{不带半波损失}')
colormap(gray(N));