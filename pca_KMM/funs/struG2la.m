function [clusternum, label] = struG2la(Z)
    [n,m] = size(Z);
    SS0 = sparse(n+m,n+m); SS0(1:n,n+1:end) = Z; SS0(n+1:end,1:n) = Z';
    [clusternum, label] = graphconncomp(SS0); %寻找强连通分量的函数是graphconncomp
    %clusternum代表当前图结构中具有多少个强连通分量，label分别指示了节点属于第几个强联通分量
    label = label(1:n)';  

end