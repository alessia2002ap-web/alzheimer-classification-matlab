function a = accuracy(ytrue,ypred)
%% ACCURACY Compute model accuracy
% |accur = accuracy(ytrue,ypred)| computes the accuracy of a model from |ytrue|, 
% which contains the correct labels, and the corresponding model predictions, 
% |ypred|. 
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% Output |a| is a value between 0 and 1.
% 
% Algorithm
% Accuracy is the number of true positives and true negatives divided by the 
% total number of observations:
% 
% $$accuracy= \frac{\sum\text{(correctly identifed)}}{\sum (\text{correctly 
% identified)}+ \sum (\text{incorrectly identified)}}$$
% 
% 
% See Also
% <https://www.mathworks.com/help/stats/confusionmat.html confusionmat>
% Create the confusion matrix
CM = confusionmat(ytrue,ypred); 
%% 
% The confusion matrix compares true and predicted labels. The number of predictions 
% that are equal to the true label are along the diagonal.
% Compute the sum of correctly identified
sumCorrect = sum(diag(CM));
% Compute the total number of observations
sumAll = sum(CM,'all');
% Compute accuracy as in the formula 
a = sumCorrect/sumAll; 
fprintf('The accuracy of the model is = %0.2f%%',accur * 100);
end