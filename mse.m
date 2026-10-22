function t = mse(ytrue,ypred)
%% MSE Calculate mean squared error
% |t = mse(ytrue,ypred)| calculates the mean squared error (MSE) for a regression 
% model from |ytrue| and |ypred|. The result is recorded in variable |mse| in 
% output table |t.|
% 
% Inputs |ytrue| and |ypred| must be numeric column vectors of equal length. 
% 
% 
% Algorithm
% MSE is the average of the squared differences between each true data point 
% ($y_i$) and its corresponding predicted value ($\hat{y}_i$):
% 
% $$MSE = \frac{1}{n}\sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2$$
mseValue = mean((ytrue-ypred).^2,"omitnan");
t = table(mseValue,'VariableNames',"mse");
end