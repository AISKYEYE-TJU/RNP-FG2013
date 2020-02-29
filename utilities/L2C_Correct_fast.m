function [dist] =  L2C_Correct_fast(X1,X2,lambda1,lambda2,tr,tt)

% ========================================================================
% Face Recognition based on Regularized Nearest Points between Image Sets, Version 1.0
% Copyright(c) 2013  Meng YANG, Pengfei Zhu, Luc Van Gool, Lei Zhang% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------

alpha = ones(size(X1,2),1)/size(X1,2);
y     =  [zeros(size(X1,1),1);1;1];
tem1  = [X1*alpha;sum(alpha);0];
energy = 1;
iter   = 1;

while energy>1e-3 && iter < 5
    beta = tr.P*(y-tem1);
    tem2 = [-X2*beta;0;sum(beta)];
    alpha = tt.P*(y-tem2);
    tem1 = [X1*alpha;sum(alpha);0];
    energy = norm(y-tem1-tem2,2)^2 + lambda1*norm(alpha,2)^2 + lambda2*norm(beta,2)^2;
    iter   = iter + 1;
end
dist       = norm(X1*alpha-X2*beta,2)^2*(tt.num1+tr.num2);
