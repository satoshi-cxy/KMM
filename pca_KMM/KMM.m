
function [laKMM, A, Ah, laKMMh,TEST1,TEST2] = KMM(X, c, m, k) %这里的X是2行1000列的
% [laKMM, laMM, BiGraph, Anc, ~, ~, ~]= KMM(X', c, m,k) : K-Multiple-Means
% Input:
%       - X: the data matrix of size nFea x nSmp, where each column is a sample
%               point
%       - c: the number of clusters 4
%       - m: the number of multiple means(MM)  63
%       - k: the number of neighbor points  5
% Output:
%       - laKMM: the cluster assignment for each point
%       - laMM: the sub-cluster assignment for each point
%       - BiGraph: the matrix of size nSmp x nMM
%       - A: the multiple means matrix of size nFea x nMM
%       - laKMMh: the history of cluster assignment for each point
% Requre:
%       CSBG.m
% 		meanInd.m
% 		ConstructA_NP.m
% 		EProjSimplex_new.m
% 		svd2uv.m
% 		struG2la.m
%       eig1.m
%       gen_nn_distanceA.m
% Usage:
%       % X: d*n, d是2即每组数据有2维，n是1000列，即1000组数据
%       [laKMM, laMM, AnchorGraph, Anchors, ~, ~, ~]= KMM(X', c, m,k) ;
% Reference:
%
%	Feiping Nie, Cheng-Long Wang, Xuelong Li, "K-Multiple-Means: A Multiple-Means 
%   Clustering Method with Specified K Clusters," In The 25th ACM SIGKDD Conference
%   on Knowledge Discovery and Data Mining (KDD'19), August 4-8, 2019, Anchorage, AK, USA.
%
%   version 1.0 --May./2019 
%
%   Written by Cheng-Long Wang (ch.l.w.reason AT gmail.com)

Ah=[];
laKMMh=[];
Iter=15;
OBJ=0;

n=size(X,2); %返回矩阵的列数
m0=m; %m is the number of multiple means, m= 63
Success=1;

    StartIndZ=kmeans(X',m);%,X'是1000X2, 将X'划分为m=63个聚类，StartIndZ记录每个点的聚类标号,

BiGraph = ones(n,m); %生成全1矩阵
%A = X(:,randperm(size(X,2),m));
A = meanInd(X, StartIndZ,m,BiGraph);%meanInd是2*63的矩阵, A是原型矩阵，总共有63个原型
%首先用matlab自带的kmeans将数据集X'分成m个类，再对每个类中的元素xi求和再求平均值，每个类的平均值就是初始的原型aj
%一开始先分成63个聚类，求每个聚类的均值作为原型aj
Ah=[Ah A];
tic
[laKMM, laMM, BiGraph, isCov, obj,TEST1, TEST2, ~] = CSBG(X, c, A, k);
laKMMh=[laKMMh laKMM];
ti=toc;
OBJ(1)=obj(end);
% fprintf('time:%d,obj:%d\n',ti,obj)
iter=1;
while(iter<Iter)
    iter = iter +1;
    if isCov
        fprintf('iter:%d\n',iter)
        OBJ(iter)=obj(end);       
%         [Z, ~, ~, id]= ConstructA_NP(X, Anc,k);
%         MidIndZ=id(:,1);
        if (all(StartIndZ==laMM))
        % if OBJ(end)==OBJ(end-1) || (all(StartInd==EndInd) & all(StartIndZ==EndIndZ))
%             Anc = meanInd(X, EndIndZ, c, Z);
            fprintf('all mid=end \n')
            return;
        elseif(length(unique(laMM))~=m)
            fprintf('length(unique(EndIndZ))~=m \n')
            StartIndZ=laMM;
            while(length(unique(StartIndZ))~=m)
                fprintf('len mid ~=m \n')
                A = A(:,unique(StartIndZ));
                m = length(unique(StartIndZ));
                if length(unique(StartIndZ))>c 
                    [BiGraph, ~, ~, id]= ConstructA_NP(X, A,k);
                    StartIndZ=id(:,1);                   
                else % re-ini
                    m=m0;
                    StartIndZ=kmeans(X',m);
                    BiGraph=ones(n,m);
                    A = meanInd(X, StartIndZ, m, BiGraph);
                    Success=0;
                end
            end
            if Success==0
                Ah=[];
            end
            Ah=[Ah A]; Success=1;               
        else
            %A = X(:,randperm(size(X,2),m));
            %Ah = [Ah A];
            fprintf('mid ~=end & len min=m \n')
            StartIndZ=laMM;  
            A = meanInd(X, StartIndZ, m, BiGraph);
            Ah=[Ah A];
        end
    else
        %A = X(:,randperm(size(X,2),m));
        %Ah = [];
        %Ah = [Ah A];
        fprintf('0~=isCov\n')
        StartIndZ=kmeans(X',m);
        BiGraph=ones(n,m);
        A = meanInd(X, StartIndZ, m, BiGraph);
        Ah=[];
        Ah=[Ah A];
    end
    
    
    [laKMM, laMM, BiGraph, isCov, obj, ~] = CSBG(X, c, A, k);
    laKMMh=[laKMMh laKMM];
    
    % fprintf('time:%s,obj:%d\n',ti,obj)
end
fprintf('loop:%d\n',iter)
end

