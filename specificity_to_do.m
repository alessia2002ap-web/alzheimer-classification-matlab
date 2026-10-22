function t = specificity(ytrue,ypred)
%% SPECIFICITY Calculate class-wise specificity
% |t = specificity(ytrue,ypred)| computes class-wise specificity for the true 
% class labels, |ytrue|, and the corresponding model predictions, |ypred|. The 
% result is recorded in variable |Specificity| in output table |t|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length.
% 
% 
% Algorithm
% The specificity for class $k$ is defined as:
% 
% $$specificity(k) = \frac{\sum\text{(correctly identifed as not class }k)}{\sum 
% (\text{correctly identified as not class }k)+ \sum(\text{incorrectly identified 
% as class } k)}$$
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
Specificity = zeros(n,1);
% Calculate the precision for each class
for k = 1:n
    % obtain by class counts of false positive and True negative classifications
    [~,~,FP,TN] = predictiveTotals(CM,k); 
    Specificity(k) = TN/(TN+FP);
end
% Create output variable table t
t = table(Specificity,'RowNames',string(classnames));
end