function [t,a] = cMetrics(ytrue,ypred)
%% CMETRICS Compute class-wise metrics
% |t = cMetrics(ytrue,ypred)| computes class-wise metrics from the true class 
% labels, |ytrue|, and the corresponding model predictions, |ypred.| Model accuracy 
% is also written to the screen as a percentage. 
% 
% |[t,a] = cMetrics(ytrue,ypred)| also returns the decimal value for model accuracy 
% in variable |a|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% Output |t| is a table containing the following metrics for each class:
%% 
% * Precision
% * Recall
% * Fallout
% * Specificity
% * $F_1$
%% 
% The last two rows of table |t| contain the average metric values across all 
% classes (|Avg|), and the average across all classes weighted by the class label 
% counts (|WgtAvg|).
% 
% 
% See Also
% <matlab:doc accuracy accuracy> | <matlab:doc precision precision> | <matlab:doc 
% recall recall> | <matlab:doc fallout fallout> | <matlab:doc specificity specificity> 
% | <matlab:doc f1 f1>
% create a table where each variable is the output of a metric function 
t = [precision(ytrue,ypred), ...
     recall(ytrue,ypred), ...
     fallout(ytrue,ypred), ...
     specificity(ytrue,ypred), ...
     f1(ytrue,ypred)];
% Compute accuracy and write the percentage to the screen
a = accuracy(ytrue,ypred);
% Compute average of each metric across all classes
avg = mean(t{:,:},1);
% Categories are in alphabetical order by default
% Place ytrue classes in the same order as rows in t
ytrue = reordercats(categorical(ytrue),t.Properties.RowNames);
% Count the number of occurrences of each class
wt = countcats(ytrue);
% Compute weighted average of each metric across all classes
% eqn: wtavg = sum(metric(i) * wt(i) / total number of labels)
wtavg = sum(t{:,:}.*wt/sum(wt),1);
tavg = array2table([avg;wtavg], ...
    "VariableNames",["Precision","Recall","Fallout","Specificity","F1"],...
    "RowNames",["Avg","WgtAvg"]);
% Add table tavg to the bottom of table t
t = [t;tavg];    
end
%% 
% Accuracy
function a = accuracy(ytrue,ypred)
% Create the confusion matrix
CM = confusionmat(ytrue,ypred); 
% Compute the sum of correctly identified
sumCorrect = sum(diag(CM));
% Compute the total number of observations
sumAll = sum(CM,'all');
% Compute accuracy as in the formula 
a = sumCorrect/sumAll; 
fprintf('The accuracy of the model is = %0.2f%%', a * 100);
end
%% 
% F1
function t = f1(ytrue,ypred)
% Obtain class-wise precision and recall values using the function
p = precision(ytrue,ypred);
r = recall(ytrue,ypred);
% Compute F1 score for each class using elementwise operators
F1 = 2*(p.Precision.*r.Recall)./(p.Precision+r.Recall);
% Create output variable table t
t = table(F1,'RowNames',p.Properties.RowNames);
end
%% 
% Specificity
function t = specificity(ytrue,ypred)
% Create the confusion matrix
[CM,classnames] = confusionmat(ytrue,ypred);
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
%% 
% Fall out
function t = fallout(ytrue,ypred)
% Create the confusion matrix
[CM,classnames] = confusionmat(ytrue,ypred);
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
%% 
% Precision
function t = precision(ytrue,ypred)
% Create the confusion matrix
[CM,classnames] = confusionmat(ytrue,ypred);
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
%% 
% Recall
function t = recall(ytrue,ypred)
% Create the confusion matrix
[CM,classnames] = confusionmat(ytrue,ypred);
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
%% 
% Predictive Totals
function [TP,FN,FP,TN] = predictiveTotals(CM,k)
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