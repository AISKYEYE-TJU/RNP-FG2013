%main

clc;
addpath utilities;

honda_setting;

tic;
RNP_classifier_solver_fast('honda_setting',lambda1,lambda2);
rate=eval_classification([RESULT_DIR 'SANP_honda_result_' num2str(set_length) '.mat']);
fid = fopen(['demo_RNP_honda.txt'],'a');
fprintf(fid,'%s%8f%s%8f%s%8f%s%8f\n','  numtrainframe = ', set_length,'  subspace_th = ',subspace_th,' lambda1 =',lambda1,'lambda2 =',lambda2);
fprintf(fid,'%s%8f%s%8f%s%8f\n',' cluster num = ',k_c,' time =',toc,' rate =',rate);
fclose(fid);

