clc;
lam=500e-9;%���벨��
a=2e-3;D=1;
ym=5*lam*D/a;xs=ym;%�趨�����ķ�Χ
n=101;ys=linspace(-ym,ym,n);%�ѹ�����y����ֳ�101��
for i=1:n
    r1=sqrt((ys(i)-a/2).^2+D^2);
    r2=sqrt((ys(i)+a/2).^2+D^2);
    phi=2*pi*(r2-r1)/lam;
    B(i,:)=4*cos(phi/2).^2;
end
N=225;%ȷ���ûҶȵȼ�Ϊ255��
Br=(B/4.0)*N;%ʹ����ǿ��Ӧ�����Ҷȼ�����ɫ��
subplot(1,2,1)
image(xs,ys,Br);%���������
title('��������_{���벨��ʧ}')
colormap(gray(N));
%�����벨��ʧ
subplot(1,2,2)
lam1=200e-9;%���벨��
a1=2e-3;D1=1;
ym1=5*lam1*D1/a1;xs1=ym1;%�趨�����ķ�Χ
n1=101;ys1=linspace(-ym1,ym1,n1);%�ѹ�����y����ֳ�101��
for i=1:n1
    r11=sqrt((ys1(i)-a1/2+0.3).^2+D1^2);
    r21=sqrt((ys1(i)+a1/2+0.3).^2+D1^2);
    phi1=2*pi*(r21-r11)/lam1;
    B1(i,:)=4*cos(phi1/2).^2;
end
N1=225;%ȷ���ûҶȵȼ�Ϊ255��
Br1=(B1/4.0)*N1;%ʹ����ǿ��Ӧ�����Ҷȼ�����ɫ��
subplot(1,2,2)
image(xs1,ys1,Br1);%���������
title('��������_{�����벨��ʧ}')
colormap(gray(N1));
figure(2)
plot(B,ys)%������ǿ�仯����
title('��ǿ�仯����_{by zhouyuchuan}')