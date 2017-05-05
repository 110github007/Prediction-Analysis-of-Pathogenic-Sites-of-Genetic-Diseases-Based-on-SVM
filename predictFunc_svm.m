%**********   ����5�۽�����֤��SVM��������Ԥ�⺯��������Ԥ�⾫��   **********%
%**********Date��2017.04.12  Group:DataMing No.5**********%
function Acc = predictFunc_svm( Pdata, Ndata, data_atrr)
Pnum=size(Pdata,1);
Nnum=size(Ndata,1);
indicesP =crossvalind('Kfold',Pnum,5); %5�۽�����֤����ָ��
indicesN =crossvalind('Kfold',Nnum,5); %5�۽�����֤�ĸ�ָ��
Acc=[];
%% ����K�۽�����֤(K=5)
for i=1:5
    Ptest = (indicesP == i);
    Ptrain = ~Ptest;
    Ntest = (indicesN == i);
    Ntrain = ~Ntest;
    Ztrain=[Ptrain;Ntrain];
    Ztest=[Ptest;Ntest];
    %% ѡ�����ݼ�ѵ�����ԺͲ�������
    train_attr =data_atrr(Ztrain==1,:); %ѵ������
    test_attr =data_atrr(Ztrain==0,:);   %��������
    %% ѵ�����Ͳ��Լ��е�������
    Ptrain_data=Pdata(Ptrain==1);
    Ptest_data=Pdata(Ptrain==0);
    %% ѵ�����Ͳ��Լ��еĸ�����
    Ntrain_data =Ndata(Ntrain==1);
    Ntest_data =Ndata(Ntrain==0);
    %% ѵ�����ı�ǩ
    train_label = vertcat( Ptrain_data, Ntrain_data);    
    %% ���Լ��ı�ǩ
    test_label = vertcat( Ptest_data, Ntest_data);
    %% ͨ��SVM������Ԥ������ѵ����ѵ��ģ��
    model = svmtrain(train_label,sparse(train_attr),'-h 0');  
    %% ͨ��SVM������Ԥ���������Լ�Ԥ�⾫��
    [~,acc,~]=svmpredict(test_label,sparse(test_attr),model);
%predicted_label, accuracy/mse, decision_values]=svmpredict(test_label,test_matrix, model, ['libsvm_options']);
%accuracy/mse��һ��3*1�������������е�1���������ڷ������⣬��ʾ����׼ȷ�ʣ�
%�������������ڻع����⣬��2�����ֱ�ʾmse�����������ֱ�ʾƽ�����ϵ����
    Acc=[Acc,acc(1,1)];%ȡ������Ԥ�⾫�Ƚ����5�ۼ����ۻ��õ�һ��1*5�ľ���
  end
end

