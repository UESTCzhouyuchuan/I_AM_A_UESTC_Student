clc;
lam=200e-9;%���벨��
a=2e-3;D=1;
ym=5*lam*D/a;xs=ym;%�趨�����ķ�Χ
n=101;ys=linspace(-ym,ym,n);%�ѹ�����y����ֳ�101��
for i=1:n
    r1=sqrt((ys(i)-a/2+0.3).^2+D^2);
    r2=sqrt((ys(i)+a/2+0.3).^2+D^2);
    phi=2*pi*(r2-r1)/lam;
    B(i,:)=4*cos(phi/2).^2;
end
N=225;%ȷ���ûҶȵȼ�Ϊ255��
Br=(B/4.0)*N;%ʹ����ǿ��Ӧ�����Ҷȼ�����ɫ��
subplot(1,1,1)
image(xs,ys,Br);%���������
title('��������_{�����벨��ʧ}')
colormap(gray(N));