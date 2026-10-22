function t = rmse(ytrue,ypred)
%% RMSE Calculate root mean square error
% |t = rmse(ytrue,ypred)| calculates the root mean square error (RMSE) for a 
% regression model from |ytrue| and |ypred|. The result is recorded in variable 
% |rmse| in output table |t.|
% 
% Inputs |ytrue| and |ypred| must be numeric column vectors of equal length. 
% 
% 
% Algorithm
% RMSE is the square root of the mean squared error, which is the average squared 
% difference between each true data point ($y_i$) and its corresponding predicted 
% value ($\hat{y}_i$):
% 
% $$RMSE = \sqrt{\frac{1}{n}\sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2}$$
% 
% 
% See Also
% <matlab:doc mse mse>
rmseValue = sqrt(mean((ytrue-ypred).^2,"omitnan"));
t = table(rmseValue,'VariableNames',"rmse");
end