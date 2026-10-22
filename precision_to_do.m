function t = precision(ytrue,ypred)
%% PRECISION Calculate class-wise precision
% |t = precision(ytrue,ypred)| computes the class-wise precision from the true 
% class labels, |ytrue|, and the corresponding model predictions, |ypred|. The 
% result is recorded in variable |Precision| in output table |t|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% 
% Algorithm
% The precision for class $k$ is defined as the number correctly labeled as 
% class k divided by the total number labeled as class k:
% 
% $$precision(k) = \frac{\sum\text{(correctly identifed as class }k)}{\sum (\text{correctly 
% identified as class } k)+ \sum(\text{incorrectly identified as class } k)} $$
% 
% 
% See Also
% <https://www.mathworks.com/help/stats/confusionmat.html confusionmat> | <matlab:doc 
% predictiveTotals predictiveTotals>
% Create the confusion matrix
[CM,classnames] = confusionmat(ytrue,ypred);
%% 
% The confusion matrix compares true and predicted labels. The number of predictions 
% that are equal to the true label are along the diagonal.
n = length(CM);
Precision = zeros(n,1);
% Calculate the precision for each class
for k = 1:n
    % obtain by class counts of true positive and false positive classifications
    [TP,~,FP,~] =  predictiveTotals(CM,k);
    Precision(k) = TP/(TP+FP);
end
% Create output variable table t
t = table(Precision,'RowNames',string(classnames));
end