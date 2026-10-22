function t = fallout(ytrue,ypred)
%% FALLOUT Calculate class-wise fallout
% |t = fallout(ytrue,ypred)| computes the class-wise fallout from the true class 
% labels, |ytrue|, and the corresponding model predictions, |ypred|. The result 
% is recorded in variable |Fallout| in output table |t|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% 
% Algorithm
% The fallout for class $k$ is defined as:
% 
% $$fallout(k) = \frac{\sum\text{(falsely identifed as class }k)}{\sum (\text{falsely 
% identified as class } k)+ \sum(\text{correctly identified as not class } k)}$$ 
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
Fallout = zeros(n,1);
% Calculate the precision for each class
for k = 1:n
    % obtain by class counts of false positive and true negative classifications
    [~,~,FP,TN] = predictiveTotals(CM,k); 
    Fallout(k) = FP/(FP+TN);
end
% Create output variable table t
t = table(Fallout,'RowNames',string(classnames));
end