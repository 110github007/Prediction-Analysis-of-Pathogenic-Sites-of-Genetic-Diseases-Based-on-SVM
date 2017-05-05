%********** ����SVM�ľ����Ŵ��Լ�������״���Ŵ�λ����� **********%
%**********   Date��2017.04.10  Group:DataMing No.5  **********%
%**********              Run Time:13 min             **********%
close all;
clear;
clc;
%% ����ʮ���Ʊ���9445��λ�����������
all_feature=textread('nowenary_encoding_feature.dat');
%train_attr=all_feature;
Pdata=zeros(500,1);
Ndata=ones(500,1);
%% �������Թ�һ������
[dataset_scale,ps] = mapminmax(all_feature',0,1);
data_attr = dataset_scale';%��һ���������������Ծ���
W=size(data_attr,2);%���ԣ�λ�㣩����
%train_label = vertcat( zeros(Pnum,1),ones(Nnum,1) );%�������ӣ���phenotype.txt
%% ѭ��ÿ��λ�㣬����ÿ�����Խ��иü�����Ԥ�⣬�õ�Ԥ�⾫��accuracy
accuracy=[];
for w=1:W
    Acc = predictFunc_svm( Pdata, Ndata,data_attr(:,w));
    accuracy=[accuracy,mean(Acc)];%5�۽���õ�ÿ�����Ե�Ԥ�⾫��
end
dlmwrite('predict_accuracy.txt',accuracy,'delimiter',' ');
%% ��Ԥ�����������У���Ԥ�⾫�� accuracy �Ӹߵ�������
%accuracy_desc:�������е�Ԥ������org_indices:�����Ԥ�⾫�ȶ�Ӧ��λ�����Ա��
[accuracy_desc,org_indices]=sort(accuracy,'descend');
accuracy_result=[accuracy_desc;org_indices];
dlmwrite('predict_accuracy_desc.txt',accuracy_result,'delimiter',' ');
%predict_accuracy_desc.txt�е�һ��Ϊ�������е�Ԥ�������ڶ���Ϊ�����Ԥ�⾫�ȶ�Ӧ��λ�����Ա��
%% ѡ��Top n Ԥ�⾫�ȼ���ӦԤ�⾫�����ڵ�λ��
n=10;
topn_accuracy=accuracy_desc(:,1:n);
topn_accuracy=topn_accuracy';
disp(topn_accuracy) ;
%���ǰ10��Ԥ�⾫��
feature_name=textread('feature_name.txt','%s','delimiter','\n');
for m=1:n
    topn_feature(m)=feature_name(org_indices(:,m),1);
end
disp(topn_feature) ;
%���ǰ10��Ԥ��λ��


