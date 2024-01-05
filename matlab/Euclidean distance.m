clc
clear
%相互作用
interaction = load('M_sd.csv');  
% load embedding features
site_feat = load('E:/豆豆/体系一修改/降维/feature/site400.txt');
dis_feat = load('E:/豆豆/体系一修改/降维/feature/disease150.txt');
%总负样本
Pnoint = find(~interaction);                             %%未知关联所处的位置索引     总负样本
[k,z] = ind2sub(size(interaction), Pnoint);       %%测试集的行（药物），列（蛋白）  将线性索引转换为下标
kz =[k,z];
%Pnoint = load('工作簿0.9.csv');  
%kz = Pnoint; 
%正样本
Pint = find(interaction);                                %%已知关联所处的位置索引     正样本
[I, J] = ind2sub(size(interaction), Pint);     %%行（药物），列（疾病）  将线性索引转换为下标

B=site_feat(I,:);
C=dis_feat(J,:);
pfeature=[B,C];
clear B C I J k z 

%%csvwrite('pfeature.csv', pfeature);

pr=sum(pfeature)/size(pfeature,1);%%聚类中心

kz1 =kz(1:100000,:);
D1 = site_feat(kz1(:,1),:);
F1 = dis_feat(kz1(:,2),:);
nfeature1=[D1,F1]; 
for i=1:length(nfeature1)
    d1=0;
    for j=1:size(nfeature1,2)
         d1=d1+(nfeature1(i,j)-pr(j))^2;
         OD1(i)=sqrt(d1);
     end
end
clear i j d1 D1 F1
kz2 =kz(100001:200000,:);
D2 = site_feat(kz2(:,1),:);
F2 = dis_feat(kz2(:,2),:);
nfeature2=[D2,F2];
for i=1:length(nfeature2)
    d2=0;
    for j=1:size(nfeature2,2)
         d2=d2+(nfeature2(i,j)-pr(j))^2;
         OD2(i)=sqrt(d2);
     end
end
clear i j d2  D2 F2
kz3 =kz(200001:end,:);
D3 = site_feat(kz3(:,1),:);
F3 = dis_feat(kz3(:,2),:);
nfeature3=[D3,F3];
for i=1:length(nfeature3)
    d3=0;
    for j=1:size(nfeature3,2)
         d3=d3+(nfeature3(i,j)-pr(j))^2;
         OD3(i)=sqrt(d3);
     end
end
clear i j d3  D3 F3


OD =[OD1,OD2,OD3];
averageOD=sum(OD)/length(Pnoint);

z1=find(OD1>0.9.*averageOD);
Rn1=nfeature1(z1,:);
Rp1=kz1(z1,:);
z2=find(OD2>0.9.*averageOD);
Rn2=nfeature2(z2,:);
Rp2=kz2(z2,:);
z3=find(OD3>0.9.*averageOD);
Rn3=nfeature3(z3,:);
Rp3=kz3(z3,:);


Rn=[Rn1;Rn2;Rn3];
Rp=[Rp1;Rp2;Rp3];

csvwrite('Nfeature1.1.csv', Rp);
%csvwrite('NfeaturePosition1.05.csv', Rp);
clear kz1 kz2 kz3 kz4 kz nfeature1 nfeature2 nfeature3 nfeature4 
clear OD1 OD2 OD3 OD4 Rn1 Rn2 Rn3 Rn4 Rp1 Rp2 Rp3 Rp4 Pint Pnoint 