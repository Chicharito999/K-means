k=input('k=');
[m ,n]=size(r);%m是向量数目 n为向量的维数
plot(r(:,1),r(:,2),'.');
%plot3(r(:,1),r(:,2),r(:,3),'.');
hold on;


%在所有向量中选出k个种子点
for i=1:k
    a=unidrnd(m);%生成1-m的随机正整数a
    for j=1:n
        heart(i,j)=r(a,j);
    end
end

while 1
    pre_heart=heart;
    %计算所有点到k个中心点的距离
    for i=1:m
        for j=1:k
            dis(i,j)=norm(r(i,:)-heart(j,:));%矩阵dis（i，j）表示r中第i个向量到第j个中心点的距离
        end
    end
    [~,index]=min(dis,[],2);%矩阵index（i,1)表示第i个向量离哪个中心点最近
    
    %计算离每个中心点更接近的点数量
    num=zeros(k,1);
    for i=1:m
        for j=1:k
            if index(i)==j
                num(j,1)=num(j,1)+1;
            end
        end
    end
    
    
    %更新中心点向量
    for i=1:k%中心点置0
        heart(i,:)=0;
    end
    for i=1:m%叠加
        for j=1:k
            if index(i)==j
                heart(j,:)=heart(j,:)+r(i,:);
            end
        end
    end
    for i=1:k%平均
        heart(i,:)=heart(i,:)/num(i,1);
    end
    
    %迭代一定次数后中心点前后变化的距离小于0.1跳出
    if norm(pre_heart-heart)<0.000001
        break;
    end
    
end

figure;

%显示聚类结果及中心点 二维点

 for i=1:m
     if index(i,1)==1
         plot(r(i,1),r(i,2),'r.');hold on;
     elseif index(i,1)==2
         plot(r(i,1),r(i,2),'y.');hold on;
     elseif index(i,1)==3
         plot(r(i,1),r(i,2),'b.');hold on;
     elseif index(i,1)==4
         plot(r(i,1),r(i,2),'g.');hold on;
     else
         plot(r(i,1),r(i,2),'m.');hold on;
     end
 end
 plot(heart(:,1),heart(:,2),'k+');


%显示聚类结果及中心点 三维点
%{
  for i=1:m
    if index(i,1)==1
        plot3(r(i,1),r(i,2),r(i,3),'r.');hold on;
    elseif index(i,1)==2
        plot3(r(i,1),r(i,2),r(i,3),'y.');hold on;
    elseif index(i,1)==3
        plot3(r(i,1),r(i,2),r(i,3),'b.');hold on;
    elseif index(i,1)==4
        plot3(r(i,1),r(i,2),r(i,3),'g.');hold on;
    elseif index(i,1)==5
        plot3(r(i,1),r(i,2),r(i,3),'m.');hold on;
    elseif index(i,1)==6
        plot3(r(i,1),r(i,2),r(i,3),'c.');hold on;
    else
        plot3(r(i,1),r(i,2),r(i,3),'k.');hold on;
    end
end

plot3(heart(:,1),heart(:,2),heart(:,3),'k+');
%}
hold on;
