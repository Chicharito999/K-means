k=input('k=');
[m ,n]=size(r);%m��������Ŀ nΪ������ά��
plot(r(:,1),r(:,2),'.');
%plot3(r(:,1),r(:,2),r(:,3),'.');
hold on;


%������������ѡ��k�����ӵ�
for i=1:k
    a=unidrnd(m);%����1-m�����������a
    for j=1:n
        heart(i,j)=r(a,j);
    end
end

while 1
    pre_heart=heart;
    %�������е㵽k�����ĵ�ľ���
    for i=1:m
        for j=1:k
            dis(i,j)=norm(r(i,:)-heart(j,:));%����dis��i��j����ʾr�е�i����������j�����ĵ�ľ���
        end
    end
    [~,index]=min(dis,[],2);%����index��i,1)��ʾ��i���������ĸ����ĵ����
    
    %������ÿ�����ĵ���ӽ��ĵ�����
    num=zeros(k,1);
    for i=1:m
        for j=1:k
            if index(i)==j
                num(j,1)=num(j,1)+1;
            end
        end
    end
    
    
    %�������ĵ�����
    for i=1:k%���ĵ���0
        heart(i,:)=0;
    end
    for i=1:m%����
        for j=1:k
            if index(i)==j
                heart(j,:)=heart(j,:)+r(i,:);
            end
        end
    end
    for i=1:k%ƽ��
        heart(i,:)=heart(i,:)/num(i,1);
    end
    
    %����һ�����������ĵ�ǰ��仯�ľ���С��0.1����
    if norm(pre_heart-heart)<0.000001
        break;
    end
    
end

figure;

%��ʾ�����������ĵ� ��ά��

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


%��ʾ�����������ĵ� ��ά��
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
