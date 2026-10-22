function t = Rsq(ytrue,ypred)
%% RSQ Calculate the coefficient of determination (R$^2$)
% |t = Rsq(ytrue,ypred)| calculates the R$^2$ value for a regression model from 
% |ytrue| and |ypred|. The result is recorded in variable |Rsq| in output table 
% |t.|
% 
% Inputs |ytrue| and |ypred| must be numeric column vectors of equal length. 
% 
% 
% Algorithm
% R$^2$ is calculated from the sum of square errors (SSE) and the sum of square 
% total (SST). 
% 
% SSE is the sum of the squared differences between each true data point ($y_i$) 
% and its corresponding predicted value ($\hat{y}_i$).
% 
% $$SSE = \sum_{i=1}^n \left( y_i - \hat{y}_i \right)^2$$
% 
% SST is the sum of the squared differences between each true data point ($y_i$) 
% and their mean ($\bar{y}$).
% 
% $$SST = \sum_{i=1}^n \left( y_i - \bar{y} \right)^2$$
% 
% R$^2$ is defined as:
% 
% $$R^2 = \frac{SST-SSE}{SST}$$
yMean = mean(ytrue,"omitnan");
SST = sum((ytrue-yMean).^2,"omitnan");
SSE = sum((ytrue-ypred).^2,"omitnan");
RsqValue = (SST-SSE)/SST;
t = table(RsqValue,'VariableNames',"Rsq");
end