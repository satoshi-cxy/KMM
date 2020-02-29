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
[laKMM,A,Ah,laKMMh, TEST1,TEST2]= KMM(X', c, m,k) ; % X'��2��1000�еľ���
toc;
result_KMM = ClusteringMeasure(y, laKMM);
%if ~fig
 %   figure('name','KMM')
  %  rl = randperm(c); %��1-4�������������
   % cm = colormap(jet(c+2)); %c = jet(m) ���ذ��� m ����ɫ����ɫͼ
    %����x��y�ֱ�Ϊn*n�ľ�����plot������x�ĵ�1�к�y�ĵ�1�ж�Ӧȡ����������һ�����ߣ�Ȼ��x�ĵڶ�����y�ĵڶ��ж�Ӧ����������һ�����ߣ������ȥֱ����n��ƥ��������
    %for i=1:c
     %   plot(X(laKMM==rl(i),1),X(laKMM==rl(i),2),'*', 'color', cm(i,:),'MarkerSize',4); hold on;
    %end
    %plot(A(1,:),A(2,:),'o','MarkerFaceColor', cm(c+2,:),'MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',5); hold on;
%end
% 
rl = randperm(c); %��1-4������������ң� c = jet(c) ���ذ��� 4 ����ɫ����ɫͼ,��4��3�У�ÿ�б�ʾ��������ǿ�ȣ�ÿ����ɫ��ʾһ������
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
%for j=1:(size(Ah,2)/m) %Ah =[Ah A], m = 63��ʾ��m��ԭ��
%j = 1;
    %A2=Ah(:,(m*(j-1)+1):(m*j)); %�ֱ�ȡ��0-63�У���64-126��
        %if fig
        %figure('name','KMM')
        %cm = colormap(jet(c+2)); %��õ�ǰɫͼ����ǰ������ɫ�ָ��������ݣ���������ɫ�ָ�m=63����������
        %la=laKMM; %laKMMhֻ��һ�У�����ֻ�����֣�1��2��3��4����ʾԭ���ݼ����ֳ�4������,laKMMh��ÿ���������ڵ�����
        %for i=1:c
        %la = 1ʱ�ǵ�һ�����ࣨ������la = 4ʱ�ǵ��ĸ����ࣨ��ͣ�
        %�����ţ�la����ͬ�����ݸ�����ͬ����ɫ
            %scatter3(X((la ==rl(i)),1),X((la == rl(i)),2),X((la == rl(i)),3)); hold on;
        
        
            %plot(X(la==rl(i),1),X(la==rl(i),2),'*', 'color', cm(i,:),'MarkerSize',8); hold on;
        %end
        %A2����ĵ�һ����Ϊ�����꣬�ڶ���������Ϊ������
        %scatter3(A2(1,:), A2(2, :), A2(3,:), '*'); hold on;
        %plot(A2(1,:),A2(2,:),'o','MarkerFaceColor', 'r','MarkerEdgeColor',0.3*cm(c+2,:),'MarkerSize',10); hold on;
        %end
%plot(x, y)�е�����һһ��Ӧy��ÿһ�е����ݣ�x��Ϊ����y��Ϊ����
