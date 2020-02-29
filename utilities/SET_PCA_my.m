function [num] = SET_PCA_my(X, subspace_th)
% X = X-repmat(mean(X,2),[1,size(X,2)]);
% way 1
% [variances] = svd(X);
% for d=1:length(variances)
%     if ( sum(variances(1:d,1)) >= (subspace_th*sum(variances)) )
%        break;
%     end
% end
% num = d;

% way 2
[variances] = svd(X);
index       = find(variances>=0.1*variances(1));
num = sum(variances);

% way 3
%     [m,n] = size(X);
%     [pcs,newdata,variances] = princomp(X');
%     nPCs = min(m,n-1);
%     all_basis = pcs(:,1:nPCs);
%     variances = variances(1:nPCs,1);
% 
%     for d=1:length(variances)
%         if ( sum(variances(1:d,1)) >= (subspace_th*sum(variances)) )
%             break;
%         end
%     end
%     num = d;
    
% way 4
%     [m,n] = size(X);
%     [pcs,newdata,variances] = princomp(X');
%     nPCs = min(m,n-1);
%     all_basis = pcs(:,1:nPCs);
%     variances = variances(1:nPCs,1);
%     num = sum(variances);


