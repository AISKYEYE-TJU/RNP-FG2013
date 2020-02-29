function 	RNP_classifier_solver_fast(config_file,lambda1,lambda2)

%%  load config file

try
eval(config_file);
catch
end

if (random_sample>0)
    load([DATA_DIR,DATASET_NAME,'/',DATASET_NAME,'_indices_',num2str(set_length),'.mat'], 'random_idices');
end

for cID2 = 1:length(Categories.Train_Frames)
    cID2
    for trainID = 1:length(Categories.Train_Frames{cID2})
        X2 = ImgData{Categories.Train_Frames{cID2}(trainID)};
        if (random_sample>0)
            X2 = X2(:,random_idices{Categories.Train_Frames{cID2}(trainID)});
        else
            X2 = X2(:,1:min(set_length,size(X2,2)));
        end 
                
        X2  =  X2./( repmat(sqrt(sum(X2.*X2)), [size(X2,1),1]) );
        [tr{cID2,trainID}.num2] = SET_PCA_my(X2, subspace_th);
        temD   =  [-X2;zeros(1,size(X2,2));ones(1,size(X2,2))];
        [tr{cID2,trainID}.P] = inv(temD'*temD+lambda2*eye(size(temD,2)))*temD';
%         [tr{cID2,trainID}.P] = (temD'*temD+lambda2*eye(size(temD,2)))\temD';
        end
end
 
tic;
sim_matrix = [];
classify_results = cell(1,length(Categories.Test_Frames));
for cID =1:Categories.Number
    classify_results{cID} = zeros(1,length(Categories.Test_Frames{cID}));
    for testID = 1:length(Categories.Test_Frames{cID})
        fprintf('Classifying %s Instance %d ',Categories.Name{cID},testID);
        X1 = ImgData{Categories.Test_Frames{cID}(testID)};
        if (random_sample>0)
            X1 = X1(:,random_idices{Categories.Test_Frames{cID}(testID)});
        else
            X1 = X1(:,1:min(set_length,size(X1,2)));
        end
        
        X1  =  X1./( repmat(sqrt(sum(X1.*X1)), [size(X1,1),1]) );
        [tt.num1] = SET_PCA_my(X1, subspace_th);
        temD   =  [X1;ones(1,size(X1,2));zeros(1,size(X1,2))];
        [tt.P] = inv(temD'*temD+lambda1*eye(size(temD,2)))*temD';
%         [tt.P] = (temD'*temD+lambda1*eye(size(temD,2)))\temD';
        
        min_dist = inf;
        dists = [];
        for cID2 = 1:length(Categories.Train_Frames)
            for trainID = 1:length(Categories.Train_Frames{cID2})
                X2 = ImgData{Categories.Train_Frames{cID2}(trainID)};
                if (random_sample>0)
                    X2 = X2(:,random_idices{Categories.Train_Frames{cID2}(trainID)});
                else
                    X2 = X2(:,1:min(set_length,size(X2,2)));
                end  
                X2  =  X2./( repmat(sqrt(sum(X2.*X2)), [size(X2,1),1]) );
                dist =L2C_Correct_fast(X1,X2,lambda1,lambda2,tr{cID2,trainID},tt);         
                dists = [dists,dist];
%                 fprintf('\nDistance between %s %d and %s %d is %f \n',Categories.Name{cID}, testID, Categories.Name{cID2}, trainID, dist);
                if (dist<min_dist)
                    min_dist = dist;
                    classify_results{cID}(testID) = cID2;
                end
                fprintf('.');
            end
        end
        fprintf('%s\n',Categories.Name{classify_results{cID}(testID)});
        sim_matrix = [sim_matrix;dists];
    end
end

fprintf(['\nTotal time: ' num2str(toc) '  seconds!']);

if (random_sample>0)
    save([RESULT_DIR,EXPERIMENT_TYPE,'_',DATASET_NAME,'_result_',num2str(set_length),'_random.mat'], 'classify_results','sim_matrix');
else
    save([RESULT_DIR,EXPERIMENT_TYPE,'_',DATASET_NAME,'_result_',num2str(set_length),'.mat'], 'classify_results','sim_matrix');
end