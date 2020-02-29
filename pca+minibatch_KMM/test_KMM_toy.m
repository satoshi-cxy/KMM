% clc;
close all;

folder_now = pwd;  addpath([folder_now, '\funs']);
n=30000; [X0,hx1,hx2,hx3,hx4,y] = face_gen(n, 0.1);c=4;   
m=floor(sqrt(n*c));k=5; fig = 1;       
Xh = [X0,-X0];
score= mypca(Xh);
Xp = score(:,1:2);
x1 = Xp(1:1500,:);
x2 = Xp(1501:3000,:);
x3 = Xp(3001:7500,:);
x4 = Xp(7501:30000,:);
laKMMh = [];
Xe1 = [];Xe2 = [];
Xnos = [];
Xfac = [];
lo = n/1000;
tic
for i = 1:30
    n1 = size(x1,1);
    n2 = size(x2,1);
    n3 = size(x3,1);
    n4 = size(x4,1);
    n11 = randperm(n1);
    n11 = n11(1:50);
    n22 = randperm(n2);
    n22 = n22(1:50);
    n33 = randperm(n3);
    n33 = n33(1:150);
    n44 = randperm(n4);
    n44 = n44(1:750);
x11 =x1(n11,:);
x22 =x2(n22,:);
x33 =x3(n33,:);
x44 =x4(n44,:);
X = [x11;x22;x33;x44];
%Xh= [X0,-X0];
%X = Xh(:,1:3);
%SCORE=mypca(Xh);
%X=SCORE(:,1:2);
x1(n11,:) = [];
x2(n22,:) = [];
x3(n33,:) = [];
x4(n44,:) = [];


    [laKMM,~,~,A,~,Ah,laKMMh ]= KMM(X', c, m,k) ;
   Xey1 = X(laKMMh == 1, :);
   Xey2 = X(laKMMh == 2, :);
   Xnose = X(laKMMh == 3, :);
   Xface = X(laKMMh == 4, :);
   Xe1 = [Xe1;Xey1];
   Xe2 = [Xe2;Xey2];
   Xnos = [Xnos;Xnose];
   Xfac = [Xfac;Xface];
   
   
end
toc;
m1 = size(Xe1,1);la1 = 1+zeros(m1,1);
m2 = size(Xe2,1);la2 = 2+zeros(m2,1);
m3 = size(Xnos,1);la3 = 3+zeros(m3,1);
m4 = size(Xfac,1);la4 = 4+zeros(m4,1);
laKMMi = [la1;la2;la3;la4];

[result_KMM,Purity] = ClusteringMeasure(y, laKMMi);

% 
r1 = randperm(c);
%for j = 1:10
%for j=1:(size(Ah,2)/m)
   % A2=Ah(:,(m*(j-1)+1):(m*j));
       
        figure('name','cxy-KMM')
        cm = colormap(jet(c+2));
        la=laKMMh(:);
        plot(Xe1(:,1),Xe1(:,2),'*', 'color', cm(r1(1),:),'MarkerSize',4); hold on;
        plot(Xe2(:,1),Xe2(:,2),'*', 'color', cm(r1(2),:),'MarkerSize',4); hold on;
        plot(Xnos(:,1),Xnos(:,2),'*', 'color', cm(r1(3),:),'MarkerSize',4); hold on;
        plot(Xfac(:,1),Xfac(:,2),'*', 'color', cm(r1(4),:),'MarkerSize',4); hold on;
        %for i=1:c
         %   plot(Xh(la==rl(i),1),X(la==rl(i),2),'*', 'color', cm(i,:),'MarkerSize',4); hold on;
        %end
       % plot(A2(1,:),A2(2,:),'o','MarkerFaceColor', 'r','MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',5); hold on;
       
%end
