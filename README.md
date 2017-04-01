# K-means
:point_up:k均值分类<br>
__________________________________________________________________________________________
Author:赵明福                                        Student ID：201400301087                            E-mail:1109646702@qq.com<br>
## 简介
　　聚类分析是机器学习领域中重要的研究课题，K-means算法是聚类分析中使用度较高的一种划分方法，具有明显的特点和优势。K-means算法于1967年由J.B. Mac Queen提出，在聚类分析中被广泛使用。根据老师课上的介绍，K-means是一种常见的无监督学习算法，也就意味着没有标注好类别的输入训练集。<br>
　　该算法成立基于一个假设：距离相近的元素聚集成簇表现出相似性，更有可能是一类。该算法认为簇是由距离靠近的元素组成的，因此把得到紧凑且独立的簇作为目标。它把n个元素根据他们的特征分为k个聚类，以便使得所获得的聚类满足：同一聚类中的对象相似度较高；而不同聚类中的对象相似度较小。
## 原理及流程　　　　　
K-means算法的工作原理：首先从n个数据中任意选取 k个点作为初始聚类中心点，然后计算各个样本到这k个中心点的距离得出相似度，将各样本点归化到离它最近的中心点所在的类。最后，计算新形成每个类的数据的平均值来得到新的中心点，如果相邻两次的聚类中心点没有任何变化或者变化不大，说明样本调整结束，已经收敛。如果前后两次中心点有变化或者变化幅度大于设定值，则需要不断重复这一过程直到收敛为止。<br>　

K-means算法的流程如下：
* 从n个点中随机选取k个点最为初始中心点　　
* 将每个点指派到最近的中心点，形成簇
* 更新中心点坐标　　　
* 循环第②-③步，直到中心点变化不大或者没有变化。<br>

可见K-means算法原理比较简单，相似度计算时可以用欧式距离、夹角余弦、曼哈顿距离等。迭代停止的条件可以是中心点的没有变化、变化小于阈值，也可以是改变所属簇的点的个数为0或者小于阈值。
## 优缺点
K-Means算法的优点主要表现在：(1)是一种解决聚类问题的经典算法，具有实现简单、计算速度快；(2)对大数据集表现出较高的实现效率，且伸缩性好；(3)时间复杂度接近于线性，适合大规模数据集。<br>　
K-means算法的缺陷主要表现为：(1)聚类后的类别的个数k是人工设定的，但是很多情况下我们并不知道应该分成几类才合适。(2)聚类结果对于初始中心点的选择敏感，由于初始点的选择是随机的，所以每次执行都会导致不同的聚类结果。对本条缺陷可以使用K-means++算法来改善。<br>
## Matlab实现及注释
```matlab
k=input('k=');
[m ,n]=size(r);%m是向量数目 n为向量的维数
%plot(r(:,1),r(:,2),'.');
plot3(r(:,1),r(:,2),r(:,3),'.');
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
    [~,index]=min(dis,[],2);%矩阵index（i,j)表示第i个向量离哪个中心点最近
    
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
%{
 for i=1:m
     if index(i,1)==1
         plot(r(i,1),r(i,2),'r.');
     elseif index(i,1)==2
         plot(r(i,1),r(i,2),'y.');
     elseif index(i,1)==3
         plot(r(i,1),r(i,2),'b.');
     elseif index(i,1)==4
         plot(r(i,1),r(i,2),'g.');
     else
         plot(r(i,1),r(i,2),'m.');
     end
 end
 plot(heart(:,1),heart(:,2),'k+');
%}
 
%显示聚类结果及中心点 三维点
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
 
hold on;
```
m是输入向量的个数，n为向量的维度；矩阵r（m，n）为输入的一系列二维或三维向量；矩阵heart（k，n）为k个n维中心点向量，初始时在所有点中随机选择；矩阵dis（m，k）表示r中m个向量到k个中心点的距离；矩阵index（m,1)表示所有m个向量的最近中心点（1-k）索引；矩阵num（k，1）表示每一簇的向量个数，更新中心点时同一簇的向量相加后除以该值；矩阵pre-heart（k，n）表示上一次迭代时的中心点向量，只有前后两次迭代中心点距离变化小于0.000001时才跳出循环。
## 结果分析
3-d数据集聚类前：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片1.png)<br>
3-d数据集聚类后：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片2.png)<br>
2-d数据集聚类前：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片3.png)<br>
2-d数据集聚类后：<br>
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片4.png)<br> 
