function t = recall(ytrue,ypred)
%% RECALL Calculate class-wise recall
% |t = recall(ytrue,ypred)| computes the class-wise recall from the true class 
% labels, |ytrue|, and the corresponding model predictions, |ypred|. The result 
% is recorded in variable |Recall| in output table |t|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% 
% Algorithm
% The recall for class $k$ is defined as the number correctly labeled as class 
% k divided by number labeled as class k in |ytrue|:
% 
% $$recall(k) = \frac{\sum\text{(correctly identifed as class }k)}{\sum (\text{correctly 
% identified as class } k)+ \sum(\text{incorrectly identified as not class } k)}$$ 
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
Recall = zeros(n,1);
% Calculate the precision for each class
for k = 1:n
    % obtain by class counts of true positive and false negative classifications
    [TP,FN,~,~] = predictiveTotals(CM,k); 
    Recall(k) = TP/(TP+FN);
end
% Create output variable table t
t = table(Recall,'RowNames',string(classnames));
end