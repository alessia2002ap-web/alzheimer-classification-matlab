function t = rMetrics(ytrue,ypred)
%% RMETRICS Calculate regression metrics
% |t = rMetrics(ytrue,ypred)| computes regression metrics from the actual values, 
% |ytrue|, and the corresponding model predictions, |ypred|. 
% 
% Inputs |ytrue| and |ypred| must be column vectors of equal length. 
% 
% Output |t| is a table containing the following metrics:
%% 
% * MAE
% * MSE
% * RMSE 
% * R$^2$
% See Also
% <matlab:doc mae mae> ||| <matlab:doc mse mse> ||| <matlab:doc Rsq Rsq>
% create a table from the outputs of each metric function
t = [mae(ytrue,ypred),...
     mse(ytrue,ypred),...
     rmse(ytrue,ypred),...
     Rsq(ytrue,ypred)];
end