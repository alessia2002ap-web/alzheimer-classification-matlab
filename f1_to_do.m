function t = f1(ytrue,ypred)
%% F1 Calculate class-wise $F_1$ scores
% |t = f1(ytrue,ypred)| computes class-wise $F_1$ scores from the true class 
% labels, |ytrue|, and the corresponding model predictions, |ypred|. The result 
% is recorded in variable |F1| in output table |t|.
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% 
% Algorithm
% The $F_1$ score for class $k$ is defined as the harmonic mean of the precision 
% and recall of class $k$:
% 
% $$F_{1,i} = 2 \frac{precision_i \cdot recall_i}{precision_i+recall_i}$$
% 
% 
% See Also
% <matlab:doc precision precision> | <matlab:doc recall recall>
% Obtain class-wise precision and recall values using the function
p = precision(ytrue,ypred);
r = recall(ytrue,ypred);
% Compute F1 score for each class using elementwise operators
F1 = 2*(p.Precision.*r.Recall)./(p.Precision+r.Recall);
% Create output variable table t
t = table(F1,'RowNames',p.Properties.RowNames);
end