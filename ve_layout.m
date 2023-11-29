%%%% NOI DUNG THUC HIEN
%%%% 1) Ve kho hinh khoi

% clc
% clear all
% close all
%Nhap kich thuoc khu vuc luu tru
dai = 50; %input('Nhap chieu dai: ');
rong = 100; %input('Nhap chieu rong: ');
cao = 5; %input('So lop pallet: ');

%Nhap kich thuoc pallet
dai_p = 1.2; %input('Nhap chieu dai Pallet: ');
rong_p = 1; %input('Nhap chieu rong Pallet: ');

%Mot so thong so khac
aisle1 = 3.5; %input('Nhap chieu rong duong di (1 chieu): ');
cua = 6; %input('Nhap tong so cua Pick-up/Drop-off cua kho: ');

%Tinh toan
l_module = dai_p + 0.12 + 0.1*2; %0.12: width of upright, 0.1: clearance l_module khoang 1.42m
w_module = rong_p*2 + 0.12 + 0.1*3 + aisle1;% w_module khoang 5.42
hang = floor((dai-3*aisle1)/l_module);
cot = floor((rong-aisle1)/w_module);
le_ngang = (rong-cot*w_module + aisle1)/2;
le_doc = dai - hang*l_module - 2*aisle1;

%ve khung nha kho
hold on
plot([0 0],[0 dai],'k-','LineWidth',1);
plot([0 rong],[dai dai],'k-','LineWidth',1);
plot([rong rong],[dai 0],'k-','LineWidth',1);
plot([rong 0],[0 0],'k-','LineWidth',1);
%khu vuc luu tam thoi
plot([0 0],[0 -10],'k-','LineWidth',1);
plot([0 rong],[-10 -10],'k-','LineWidth',1);
plot([rong rong],[-10 0],'k-','LineWidth',1);
%khu vuc parking
% plot([0 0],[-10 -20],'k-','LineWidth',1);
% plot([0 15],[-20 -20],'k-','LineWidth',1);
% plot([15 15],[-20 -10],'k-','LineWidth',1);
plot([15 15],[-10 0],'k-','LineWidth',1);
grid on

%ve duong di doc
for j = 0:cot
    for i= 1:(hang-1)        
        x = le_ngang + j*w_module - 1.5; y1 = le_doc + (i-0.5)*l_module; y2 = le_doc + (i+0.5)*l_module;
        if i == floor(hang/2)
            y2 = le_doc + (i+0.5)*l_module + 3;
        end
        if i > floor(hang/2) 
            y1 = le_doc + (i-0.5)*l_module + 3;
            y2 = le_doc + (i+0.5)*l_module + 3;
        end
        plot([x x],[y1 y2],'b.-','LineWidth',0.5);
    end
end

%ve duong ngang
for j = 0:2
    for i= 0:(cot-1)
        x1 = le_ngang + i*w_module - 1.5;
        y = le_doc + j*((hang/2)*l_module+3)-1.5;
        if j == 1
            y = 24.74;
        end
        x2 = le_ngang + i*w_module + rong_p/2;
        x3 = le_ngang + i*w_module + rong_p*3/2 + 0.12 + 0.1*3/2;
        x4 = le_ngang + (i+1)*w_module + rong_p/2;
        if i == (cot-1)
            plot([x2 x3],[y y],'b.-','LineWidth',0.5);
        else
            plot([x2 x3],[y y],'b.-','LineWidth',0.5);
            plot([x3 x4],[y y],'b.-','LineWidth',0.5);
        end
    end
end
plot([95.61 94.96],[47.5 47.5],'b-','LineWidth',0.5);
plot([95.61 94.96],[24.74 24.74],'b-','LineWidth',0.5);
plot([95.61 94.96],[3.5 3.5],'b-','LineWidth',0.5);

%ve cung xoay o nut giao
for j = 0:1
    for i = 0:(cot-1)
        t = pi:pi/90:3*pi/2; % tren phai
        x = le_ngang + i*w_module + 0.5 + 2*cos(t);
        y = le_doc + j*(round(hang/2)*l_module+3/2) + 0.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
    end
end

for j = 0:1
    for i = 1:cot
        t = 3*pi/2:pi/90:2*pi; %tren trai
        x = le_ngang + i*w_module - 3.5 + 2*cos(t);
        y = le_doc + j*(round(hang/2)*l_module+3/2) + 0.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
    end
end

for j = 1:2
    for i = 0:(cot-1)
        t = pi/2:pi/90:pi; % duoi phai
        x = le_ngang + i*w_module + 0.5 + 2*cos(t);
        y = le_doc + j*(round(hang/2)*l_module+3/2) + (j-1)*3/2 - 3.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
    end
end

for j = 1:2
    for i = 1:cot
        t = 0:pi/90:pi/2; % duoi trai
        x = le_ngang + i*w_module - 3.5 + 2*cos(t);
        y = le_doc + j*(round(hang/2)*l_module+3/2) + (j-1)*3/2 - 3.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
    end
end

%cua phong lanh
for j = 0:2
        t = pi:pi/90:3*pi/2; % tren phai
        x = 38.41+j*2*w_module + 2 + 2*cos(t);
        y = 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
        t = 3*pi/2:pi/90:2*pi; %tren trai
        x = 38.41+j*2*w_module - 2 + 2*cos(t);
        y = 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
        plot([38.41+j*2*w_module+2 38.41+j*2*w_module+2],[0 -2],'b','LineWidth', 0.5);
        plot([38.41+j*2*w_module-2 38.41+j*2*w_module-2],[0 -2],'b','LineWidth', 0.5);
        plot([38.41+j*2*w_module 38.41+j*2*w_module], [5.76 0],'b.-','LineWidth', 0.5);
        
        t = pi/2:pi/90:pi; % duoi phai
        x = 38.41+j*2*w_module + 2 + 2*cos(t);
        y = 1.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);

        t = 0:pi/90:pi/2; %duoi trai
        x = 38.41+j*2*w_module -2+ 2*cos(t);
        y = 1.5 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        plot([38.41+j*2*w_module 38.41+j*2*w_module], [-3 0],'b.-','LineWidth', 0.5);
        
        t = pi:pi/90:3*pi/2; % tren phai
        x = 38.41+j*2*w_module + 2 + 2*cos(t);
        y = -3+2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
        t = 3*pi/2:pi/90:2*pi; %tren trai
        x = 38.41+j*2*w_module - 2 + 2*cos(t);
        y = -3+2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
end

plot([15 84], [-5 -5],'b-','LineWidth', 0.5);

%Ve cua dispatch
for j = 0:(cua-1)
        t = pi:pi/90:3*pi/2; % tren phai
        x = 26.57+j*11.84 +2 + 2*cos(t);
        y = -10 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
        t = 3*pi/2:pi/90:2*pi; %tren trai
        x = 26.57+j*11.84 - 2 + 2*cos(t);
        y = -10 + 2*sin(t);
        plot(x,y,'b','LineWidth', 0.5);
        
        plot([26.57+j*11.84+2 26.57+j*11.84+2],[-10 -12],'b','LineWidth', 0.5);
        plot([26.57+j*11.84-2 26.57+j*11.84-2],[-10 -12],'b','LineWidth', 0.5);
        plot([26.57+j*11.84 26.57+j*11.84],[-10 -7],'b','LineWidth', 0.5);
        if j == (cua-1)
            t = 0:pi/90:pi/2; %duoi trai
            x = 26.57+j*11.84 - 2 + 2*cos(t);
            y = -7 + 2*sin(t);
            plot(x,y,'b','LineWidth', 0.5);
        else
            t = pi/2:pi/90:pi; % duoi phai
            x = 26.57+j*11.84 + 2 + 2*cos(t);
            y = -7 + 2*sin(t);
            plot(x,y,'b','LineWidth', 0.5);

            t = 0:pi/90:pi/2; %duoi trai
            x = 26.57+j*11.84 -2+ 2*cos(t);
            y = -7 + 2*sin(t);
            plot(x,y,'b','LineWidth', 0.5);
        end
end

%Ve khu vuc do cho AGV (diem)
plot3(2.5, -2.5, 0,'b.');
plot3(7.5, -2.5, 0,'b.');
plot3(12.5, -2.5, 0,'b.');
plot3(2.5, -7.5, 0,'b.');
plot3(7.5, -7.5, 0,'b.');
plot3(12.5, -7.5, 0,'b.');


A = xlsread('toa_do.xlsx','Toa do','B2:D2307');
x = A(:,1);
y = A(:,2);
z = A(:,3);
for i=1:425
    plot3([x(i) x(i+1798)], [y(i) y(i+1798)], [z(i) z(i+1798)],'b','LineWidth', 0.5);
end

% text(2.5,-5,'Parking Area','Color','red','FontSize',10)
%ve diem va stt
for i = 1:2251
    plot3(x(i),y(i), z(i),'b.');
%     text(2,8,'A Simple Plot','Color','red','FontSize',14)
end

%ve pallet racking system
for k = 1:cao
     for i= 0:(cot-1)
        for j=0:(hang-1)
                    x1=le_ngang + i*w_module;y1=le_doc + j*l_module;
                    x2=le_ngang + i*w_module + rong_p ;y2=le_doc + j*l_module;
                    x3=le_ngang + i*w_module + rong_p ;y3=le_doc + j*l_module + dai_p;
                    x4=le_ngang + i*w_module ;y4=le_doc + j*l_module + dai_p;
                    z = k; z1 = k-1;
                    patch([x1,x2,x3,x4],[y1,y2,y3,y4],[z z z z],'red');
                    patch([x1,x1,x4,x4],[y1,y1,y4,y4],[z z1 z1 z],'red');
                    patch([x1,x2,x2,x1],[y1,y2,y2,y1],[z z z1 z1],'red');
                    patch([x2,x3,x3,x2],[y2,y3,y3,y2],[z z z1 z1],'red');
                    patch([x3,x4,x4,x3],[y3,y4,y4,y3],[z z z1 z1],'red');
                    
                    x5=le_ngang + i*w_module + rong_p + 0.12 + 0.1*2; y5=le_doc + j*l_module;
                    x6=le_ngang + i*w_module + 2*rong_p + 0.12 + 0.1*2;y6=le_doc + j*l_module;
                    x7=le_ngang + i*w_module + 2*rong_p + 0.12 + 0.1*2;y7=le_doc + j*l_module + dai_p;
                    x8=le_ngang + i*w_module + rong_p + 0.12 + 0.1*2;y8=le_doc + j*l_module + dai_p;
                    z = k; z1 = k-1;
                    patch([x5,x6,x7,x8],[y5,y6,y7,y8],[z z z z],'red');
                    patch([x5,x5,x8,x8],[y5,y5,y8,y8],[z z1 z1 z],'red');
                    patch([x5,x6,x6,x5],[y5,y6,y6,y5],[z z z1 z1],'red');
                    patch([x6,x7,x5,x6],[y6,y7,y7,y6],[z z z1 z1],'red');
                    patch([x7,x8,x8,x7],[y7,y8,y8,y7],[z z z1 z1],'red');     
                    if j == floor(hang/2-1)
                        le_doc = le_doc + aisle1;
                    end
        end
              le_doc = le_doc - aisle1;
     end
end
