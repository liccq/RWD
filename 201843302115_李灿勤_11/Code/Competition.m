%% 求评论跟星级的权重
score_mat = [1,3;1/3,1]     % 填写判断矩阵
% 归一化处理
[a,b] = size(score_mat)
sum_score_mat = sum(score_mat,1)    % 按列求和
sum_col = repmat(sum_score_mat,a,1)
weight = score_mat ./ sum_col   
% 因为一致性矩阵满足行间成倍数关系，所以只用求一列
weight = weight(:,1)    % 即评论的权重为0.75，星级的权重为0.25

%% 用特征值求写评论的四种不同类型的人所占权重
% 第一步：求出矩阵的最大特征值以及其对应的特征向量
load  customer_type_mat
customer_type_mat
[V,D] = eig(customer_type_mat) % V是特征向量，D是由特征值构成的对角矩阵（除了对角线元素外，其他元素都为0）
Max_eig = max(max(D))
% 判断该判断矩阵是否满足一致性
[m,n] = size(customer_type_mat)
CI = (Max_eig - n) / (n-1);
RI = [0,0,0.52,0.89,1.12,1.26,1.36,1.41,1.46,1.49,1.52,1.54,1.56,1.58,1.59]    % 查找对应的平均随机一致性指标RI
CR = CI/RI(n);
disp('一致性指标CI=');disp(CI);
disp('一致性比例CR=');disp(CR);
if CR < 0.10
    disp('We can accept the consistency of the matrix because CR < 0.1')
else
    disp('We can not accept the consistency of the matrix because CR > 0.1')
end

D == Max_eig      % 找到最大特征值在D中的位置
[row,col] = find(D == Max_eig,1)

% 第二步：对求出的特征向量进行归一化即可得到权重
V_col = V(:,col)    % 选中最大特征值所在的第一列
sum_V_col = sum(V_col)
disp('权重分别为：');
disp( V_col ./ sum_V_col ) % 即四种不同类型的评论者的权重分别为0.5232,0.1222,0.2976,0.0570(v_p,v_np,nv_p,nv_np)

%% 求满意度跟参考价值的权重
sat_ref_mat = [1,3;1/3,1]
% 归一化处理
[a,b] = size(sat_ref_mat)
sum_sat_ref_mat = sum(sat_ref_mat,1) %按列求和
sum_col = repmat(sum_sat_ref_mat,a,1)
weight_sat = sat_ref_mat ./ sum_col 
% 因为一致性矩阵满足行间成倍数关系，所以只用求一列
weight_sat = weight_sat(:,1) % 即满意度的权重为0.75，参考价值的权重为0.25

%% 将评论、星级、评论者类型标准化
load standard_mat.mat
standard_mat
[m,n] = size(standard_mat)
result_standard_mat = standard_mat ./ repmat(sum(standard_mat .* standard_mat) .^ 0.5,m,1)


