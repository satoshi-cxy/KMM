% clc;
close all;

folder_now = pwd;  addpath([folder_now, '\funs']);

n=1000; [X0, y] = face_gen(n, 0.1);c=4;  
X1 = [X0,-X0];
%X1 = X1(:,1:3);
score = mypca(X1);
X = score(:,1:2);
%[COEFF SCORE latent]=pca(X1);
%X=SCORE(:,1:2);
m=floor(sqrt(n*c));
%m = 63;
%m = 123;
k=5; 
fig = 1;       

tic
[laKMM,A,Ah,laKMMh, TEST1,TEST2]= KMM(X', c, m,k) ; % X'是2行1000列的矩阵
toc;
result_KMM = ClusteringMeasure(y, laKMM);
%if ~fig
 %   figure('name','KMM')
  %  rl = randperm(c); %将1-4的数字随机打乱
   % cm = colormap(jet(c+2)); %c = jet(m) 返回包含 m 种颜色的颜色图
    %比如x和y分别为n*n的矩阵，则plot函数将x的第1列和y的第1列对应取出来，绘制一条曲线，然后将x的第二列与y的第二列对应起来，绘制一条曲线，如此下去直到第n条匹配绘制完成
    %for i=1:c
     %   plot(X(laKMM==rl(i),1),X(laKMM==rl(i),2),'*', 'color', cm(i,:),'MarkerSize',4); hold on;
    %end
    %plot(A(1,:),A(2,:),'o','MarkerFaceColor', cm(c+2,:),'MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',5); hold on;
%end
% 
rl = randperm(c); %将1-4的数字随机打乱， c = jet(c) 返回包含 4 种颜色的颜色图,有4行3列，每列表示红绿蓝的强度，每种颜色表示一个聚类
for j=1:(size(Ah,2)/m)
    A2=Ah(:,(m*(j-1)+1):(m*j));
        if fig
        figure('name','pca-KMM')
        cm = colormap(jet(c+2));
        la=laKMMh(:,j);
        for i=1:c
            %scatter3(X((la ==rl(i)),3),X((la == rl(i)),1),X((la == rl(i)),2)); hold on;
            plot(X(la==rl(i),2),X(la==rl(i),1),'*', 'color', cm(i,:),'MarkerSize',8); hold on;
        end
        %plot(A2(1,:),A2(2,:),'o','MarkerFaceColor', 'r','MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',5); hold on;
        end
end
%for j=1:(size(Ah,2)/m) %Ah =[Ah A], m = 63表示有m个原型
%j = 1;
    %A2=Ah(:,(m*(j-1)+1):(m*j)); %分别取第0-63列，第64-126列
        %if fig
        %figure('name','KMM')
        %cm = colormap(jet(c+2)); %获得当前色图矩阵，前四种颜色分给分配数据，后两种颜色分给m=63个聚类中心
        %la=laKMM; %laKMMh只有一列，数据只有四种（1，2，3，4）表示原数据集共分成4个聚类,laKMMh是每个数据所在的类标号
        %for i=1:c
        %la = 1时是第一个聚类（脸部）la = 4时是第四个聚类（嘴巴）
        %将类标号（la）相同的数据赋予相同的颜色
            %scatter3(X((la ==rl(i)),1),X((la == rl(i)),2),X((la == rl(i)),3)); hold on;
        
        
            %plot(X(la==rl(i),1),X(la==rl(i),2),'*', 'color', cm(i,:),'MarkerSize',8); hold on;
        %end
        %A2矩阵的第一行作为横坐标，第二行数据作为列坐标
        %scatter3(A2(1,:), A2(2, :), A2(3,:), '*'); hold on;
        %plot(A2(1,:),A2(2,:),'o','MarkerFaceColor', 'r','MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',10); hold on;
        %end
%plot(x, y)列的数据一一对应y中每一列的数据，x作为横轴y作为纵轴
