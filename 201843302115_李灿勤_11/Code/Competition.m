%% �����۸��Ǽ���Ȩ��
score_mat = [1,3;1/3,1]     % ��д�жϾ���
% ��һ������
[a,b] = size(score_mat)
sum_score_mat = sum(score_mat,1)    % �������
sum_col = repmat(sum_score_mat,a,1)
weight = score_mat ./ sum_col   
% ��Ϊһ���Ծ��������м�ɱ�����ϵ������ֻ����һ��
weight = weight(:,1)    % �����۵�Ȩ��Ϊ0.75���Ǽ���Ȩ��Ϊ0.25

%% ������ֵ��д���۵����ֲ�ͬ���͵�����ռȨ��
% ��һ�������������������ֵ�Լ����Ӧ����������
load  customer_type_mat
customer_type_mat
[V,D] = eig(customer_type_mat) % V������������D��������ֵ���ɵĶԽǾ��󣨳��˶Խ���Ԫ���⣬����Ԫ�ض�Ϊ0��
Max_eig = max(max(D))
% �жϸ��жϾ����Ƿ�����һ����
[m,n] = size(customer_type_mat)
CI = (Max_eig - n) / (n-1);
RI = [0,0,0.52,0.89,1.12,1.26,1.36,1.41,1.46,1.49,1.52,1.54,1.56,1.58,1.59]    % ���Ҷ�Ӧ��ƽ�����һ����ָ��RI
CR = CI/RI(n);
disp('һ����ָ��CI=');disp(CI);
disp('һ���Ա���CR=');disp(CR);
if CR < 0.10
    disp('We can accept the consistency of the matrix because CR < 0.1')
else
    disp('We can not accept the consistency of the matrix because CR > 0.1')
end

D == Max_eig      % �ҵ��������ֵ��D�е�λ��
[row,col] = find(D == Max_eig,1)

% �ڶ�����������������������й�һ�����ɵõ�Ȩ��
V_col = V(:,col)    % ѡ���������ֵ���ڵĵ�һ��
sum_V_col = sum(V_col)
disp('Ȩ�طֱ�Ϊ��');
disp( V_col ./ sum_V_col ) % �����ֲ�ͬ���͵������ߵ�Ȩ�طֱ�Ϊ0.5232,0.1222,0.2976,0.0570(v_p,v_np,nv_p,nv_np)

%% ������ȸ��ο���ֵ��Ȩ��
sat_ref_mat = [1,3;1/3,1]
% ��һ������
[a,b] = size(sat_ref_mat)
sum_sat_ref_mat = sum(sat_ref_mat,1) %�������
sum_col = repmat(sum_sat_ref_mat,a,1)
weight_sat = sat_ref_mat ./ sum_col 
% ��Ϊһ���Ծ��������м�ɱ�����ϵ������ֻ����һ��
weight_sat = weight_sat(:,1) % ������ȵ�Ȩ��Ϊ0.75���ο���ֵ��Ȩ��Ϊ0.25

%% �����ۡ��Ǽ������������ͱ�׼��
load standard_mat.mat
standard_mat
[m,n] = size(standard_mat)
result_standard_mat = standard_mat ./ repmat(sum(standard_mat .* standard_mat) .^ 0.5,m,1)


