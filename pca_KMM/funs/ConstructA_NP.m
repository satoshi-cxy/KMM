function [Z, Alpha, Dis, id, tmp]= ConstructA_NP(A, B, k, isSparse) % ConstructA_NP(X, A,k) ConstructA_NP(A, X,k)
% d*n
% Z is sparse��ȷ�������Ƿ�Ϊϡ�����
% writed by Cheng-Long Wang ,mail:ch.l.w.reason@gmail.com
%nargin�������ж�������������ĺ�����������Բ�ͬ��������趨һЩĬ��ֵ
if nargin<4
    isSparse = 1;
end
if nargin<3
    k = 5;
end
n = size(A,2); %n1 = 1000�� n2 = 63
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
            [di(:,i),id(:,i)] = max(distXt, [], 2);%��disXt��ÿ�е����Ԫ�أ�id��¼û��Ԫ�����ڵ���
            temp = (id(:,i)-1)*n+[1:n]';
            distXt(temp) = 0;
        end
        id=fliplr(id); %������A�����ƴ�ֱ��������ҷ�ת
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
    Dis = sqdist2(A,B);%��ʾ1000�����ݷֱ��63��ԭ��֮��ľ���
    distXt = Dis; %distXt��A��B��ŷ�Ͼ��룬��ʾÿ�����ݵ�i������ԭ�͵�j�ľ��룬1000X63
    di = zeros(n,k+1);
    id = di;  
    for i = 1:k+1
        [di(:,i),id(:,i)] = min(distXt, [], 2); %����һ���У�1000�У���������i��Ԫ�ر�ʾ��i����Сֵ��id�洢ÿ����СԪ�����ڵ��к�
        %min(distXt, [], 2)ѭ����ֵk+1�Σ�ÿ�η���ÿ�е���Сֵ�Լ���Сֵ���кţ��ֱ������di��id�� k+1��ѭ������
        %di�е�ÿ��Ԫ�ذ����ݵ���ԭ�͵ľ����С��������id�е�Ԫ�ؼ�¼����
        temp = (id(:,i)-1)*n+[1:n]';
        distXt(temp) = 1e100;
    end
end

m = size(B,2);
clear distXt temp
id(:,end) = [];

Alpha = 0.5*(k*di(:,k+1)-sum(di(:,1:k),2)); %��� =�� sum(,2)����һ������������ÿ��֮��Alpha��1000X1������
ver=version;
if(str2double(ver(1:3))>=9.1) %./�Ǿ����Ӧ��ÿ��Ԫ�����
    tmp = (di(:,k+1)-di(:,1:k))./(2*Alpha+eps); % for the newest version(>=9.1) of MATLAB���������е�Sij��eps = eps(1) = 2.2204e-16
    %for j = 1:k
    %sij = (di(:,k+1)-di(:,j))/(2*Alpha+eps)��tmp��1000��5�еľ���
else
    tmp =  bsxfun(@rdivide,bsxfun(@minus,di(:,k+1),di(:,1:k)),2*Alpha+eps); % for old version(<9.1) of MATLAB
end
%repmat([1:n],1,k)��������չ��1��5000��
%S = sparse(i,j,s,m,n,nzmax)������i,j,s������������һ��m*n��ϡ�����
%tmp(:)�ǽ�tmp��ÿһ��������ͬһ���У����1000*k��1�еľ���idͬ����5000��1�еľ���
Z = sparse(repmat([1:n],1,k),id(:),tmp(:),n,m);%repmat([1:n],1,k)��5000�У�id(:)��1000�У�
%ϡ������ܹ���n�У���Ϊ[1:n]�����кţ�m�У���Ϊid�������������кţ��洢tmp�����е�����
%Z = tmp;
%sparse(u,v,S)������u,v,S��3���ȳ���������S��Ҫ������ϡ��洢����ķ���Ԫ�أ�u(i)��v(i)�ֱ���S(i)���к����±ꡣ
if ~isSparse
    Z=full(Z);
end
return
