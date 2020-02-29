function [Z, Alpha, Dis, id, tmp]= ConstructA_NP(A, B, k, isSparse) % ConstructA_NP(X, A,k) ConstructA_NP(A, X,k)
% d*n
% Z is sparse，确定输入是否为稀疏矩阵
% writed by Cheng-Long Wang ,mail:ch.l.w.reason@gmail.com
%nargin是用来判断输入变量个数的函数，可以针对不同的情况来设定一些默认值
if nargin<4
    isSparse = 1;
end
if nargin<3
    k = 5;
end
n = size(A,2); %n1 = 1000， n2 = 63
if isempty(B) || n==size(B,2)
    B = A;
    m=n;
    if n>10000
        block_size = 10;
        save_type = 3;
        Dis = gen_nn_distanceA(A', k+1, block_size, save_type);
        distXt = Dis;
        di = zeros(n,k+1);
        id = di;  
        for i = 1:k+1
            [di(:,i),id(:,i)] = max(distXt, [], 2);%求disXt中每列的最大元素，id记录没个元素所在的行
            temp = (id(:,i)-1)*n+[1:n]';
            distXt(temp) = 0;
        end
        id=fliplr(id); %将矩阵A的列绕垂直轴进行左右翻转
        di=fliplr(di);
    else
        Dis = sqdist2(A,B); % O(ndm)
        distXt = Dis;
        di = (zeros(n,k+2));
        id = di;  
        for i = 1:k+2
            [di(:,i),id(:,i)] = min(distXt, [], 2);
            temp = (id(:,i)-1)*n+[1:n]';
            distXt(temp) = 1e100;
        end
        di(:,1) = [];
        id(:,1) = [];
    end
else
    Dis = sqdist2(A,B);%表示1000个数据分别和63个原型之间的距离
    distXt = Dis; %distXt是A和B的欧氏距离，表示每个数据点i到各个原型点j的距离，1000X63
    di = zeros(n,k+1);
    id = di;  
    for i = 1:k+1
        [di(:,i),id(:,i)] = min(distXt, [], 2); %返回一个列（1000行）向量，第i个元素表示第i行最小值，id存储每个最小元素所在的行号
        %min(distXt, [], 2)循环求值k+1次，每次返回每行的最小值以及最小值的行号，分别输入给di和id， k+1次循环过后
        %di中的每行元素按数据点与原型的距离从小到大排序，id中的元素记录类标号
        temp = (id(:,i)-1)*n+[1:n]';
        distXt(temp) = 1e100;
    end
end

m = size(B,2);
clear distXt temp
id(:,end) = [];

Alpha = 0.5*(k*di(:,k+1)-sum(di(:,1:k),2)); %求γ =， sum(,2)返回一个列向量，求每行之和Alpha是1000X1的数组
ver=version;
if(str2double(ver(1:3))>=9.1) %./是矩阵对应的每个元素相除
    tmp = (di(:,k+1)-di(:,1:k))./(2*Alpha+eps); % for the newest version(>=9.1) of MATLAB，求论文中的Sij，eps = eps(1) = 2.2204e-16
    %for j = 1:k
    %sij = (di(:,k+1)-di(:,j))/(2*Alpha+eps)，tmp是1000行5列的矩阵
else
    tmp =  bsxfun(@rdivide,bsxfun(@minus,di(:,k+1),di(:,1:k)),2*Alpha+eps); % for old version(<9.1) of MATLAB
end
%repmat([1:n],1,k)将矩阵扩展成1行5000列
%S = sparse(i,j,s,m,n,nzmax)——由i,j,s三个向量创建一个m*n的稀疏矩阵
%tmp(:)是将tmp的每一列整合再同一列中，变成1000*k行1列的矩阵，id同理变成5000行1列的矩阵
Z = sparse(repmat([1:n],1,k),id(:),tmp(:),n,m);%repmat([1:n],1,k)有5000列，id(:)有1000行，
%稀疏矩阵总共有n行（因为[1:n]代表行号，m列（因为id（：））代表列号，存储tmp上所有的数字
%Z = tmp;
%sparse(u,v,S)：其中u,v,S是3个等长的向量。S是要建立的稀疏存储矩阵的非零元素，u(i)、v(i)分别是S(i)的行和列下标。
if ~isSparse
    Z=full(Z);
end
return
