function [TP,FN,FP,TN] = predictiveTotals(CM,k)
%% PREDICTIVETOTALS Count class predictive totals by type
% |[TP,FN,FP,TN] = predictiveTotals(CM,k)| computes the True Positive, False 
% Negative, False Positive, and True Negative totals for class k using the confusion 
% matrix |CM|. 
% 
% 
% Algorithm
% These predictive totals can be calculated from the confusion matrix using 
% the following equations. 
% 
% $$TP_k = CM_{kk}$$
% 
% $$ FN_k = \sum_{j}CM_{kj}  - TP_k$$
% 
% $$FP_k = \sum_{i}CM_{ik}  - TP_k$$
% 
% $$TN_k = \sum_{ i,j}CM_{ij} - TP_k - FN_k - FP_k$$
% 
% where:
%% 
% * $CM_{ij}$ is the entry in row $i$ and column $j$ of the confusion matrix 
% |CM|
% * $TP_k$ is the number of true positives for class $k$
% * $FN_k$ is the number of false negatives for class $k$
% * $FP_k$ is the number of false positives for class $k$
% * $TN_k$ is the number of true negatives for class $k$
% 
% See Also
% <https://www.mathworks.com/help/stats/confusionmat.html confusionmat>
% CM is the confusion matrix, rows represent the true class, and columns represent the predicted class
% Entries along the diagonal (row==column) indicate the number of observations whose label was correctly predicted.
% k is the number of the selected class for which computing the predictives.
TP = CM(k,k);                  % True positive
% Row k means observations that are actually class k
FN = sum(CM(k,:))-TP;          % False negative
% Column k means observations that were predicted to be class k
FP = sum(CM(:,k))-TP;          % False positive
TN = sum(CM,'all')-TP-FN-FP;   % True negative
        
end