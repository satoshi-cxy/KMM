function [X, y] = face_gen(num, noise)

n1=floor(0.05*num);
n3=floor(0.15*num);
n4=floor(0.75*num);

interval1=1.25; interval2=1.25;
% left eye
m = [-interval1,interval2]; %m是需要生成的数据的均值
C = 0.5*noise*eye(2); %eye(n)返回一个n*n的矩阵,C是需要生成的数据的自相关矩阵
x1 = mvnrnd(m,C,n1); %mvnrnd 是用来生成多维正态数据的,mvnrnd函数可以用于生成不同类别模式的数据，数据要服从正态分布
y1 = 1+zeros(n1,1);
% right eye
m = [interval1,interval2];
x2 = mvnrnd(m,C,n1);
y2 = 2+zeros(n1,1);

% nose 
x3=zeros(n3,2);
r=1.5
t=(5/4*pi):pi/(2*n3-1):(7/4*pi); % 下半圆,从3.970开始，每列数字逐渐加0.0105，一直加到等于(7/4*pi)为止
x3(:, 1) = r.*cos(t)'+randn(n3,1)*noise; %randn函数产生标准正态分布的随机数
x3(:, 2) = r.*sin(t)'+randn(n3,1)*noise;
y3 = 3+zeros(n3,1);

% face
upright = 0.5;
x4=zeros(n4,2);
r = 3;
curve = 2.5;
t = unifrnd(0,0.8,[1,n4]);
x4(:, 1) = r.*sin(curve*pi*t) + noise*randn(1,n4);
x4(:, 2) = r.*cos(curve*pi*t) + noise*randn(1,n4)+upright;;
y4 = 4+zeros(n4,1);

X = [x1;x2;x3;x4]; %进行行扩展,X 是950行2列的矩阵
y = [y1;y2;y3;y4];