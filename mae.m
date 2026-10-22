function t = mae(ytrue,ypred)
%% MAE Calculate mean absolute error
% |t = mae(ytrue,ypred)| calculates the mean absolute error (MAE) for a regression 
% model from |ytrue| and |ypred|. The result is recorded in variable |mae| in 
% output table |t.|
% 
% Inputs |ytrue| and |ypred| must be numeric column vectors of equal length. 
% 
% 
% Algorithm
% MAE is the average of the absolute differences between each true data point 
% ($y_i$) and its corresponding predicted value ($\hat{y}_i$):
% 
% $$MAE = \frac{1}{n}\sum_{i=1}^n \left| y_i - \hat{y}_i \right|$$
maeValue = mean(abs(ytrue-ypred),"omitnan");
t = table(maeValue,'VariableNames',"mae");
end