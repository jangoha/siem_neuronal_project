function [new_y_values myNet] = adaptive_plotting(x_values,fst_y_values,nIterations)


q = length(fst_y_values);
% input        = fst_y_values(1:q-1)';
n            = length(x_values);
% comp         = fst_y_values(q);
new_y_values = [fst_y_values,zeros(1,n-q)];

% net     = generate_tanh_feedforward([q-1,2,1]);
net     = generate_tanh_feedforward([q-1,3,1],'Bias','active');
% net     = train(net,input, comp, 0.01, nIterations);

for k=q:n-1
    
    input   = new_y_values(k-q+1:k-1)';
    comp    = new_y_values(k);
    
    net.Weights             = generate_bias_weights(net,[-1,1]); 
%     net.Weights             = {net.Weights{:},generate_OutputWeights(net,'identity')};
    
%     net     = train(net,input, comp, 0.01, nIterations);
    net     = train(net,input, comp, 0.01, 0.1, nIterations);
%     showWeights = net.Weights{1};
%     figure(123123);plot(showWeights');shg
    net.TrainingStatus = 'untrained';
%     sum(showWeights)
    new_y_values(k+1)   = test_net(net,input);
% pause
end
myNet = net;

% x_values = linspace(0,7,100);
% y = sin(5*x_values);
% fst_y_values = y(1:5);