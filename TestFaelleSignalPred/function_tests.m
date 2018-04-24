clear all

x=linspace(0,100,2500);
% func = @(x) 0.5*sin(7*x)+3*sinc(x-6);
func1 = @(x) sinc(x)+sinc(x-10)+sinc(x-20)+sinc(x-30);
func2 = @(x) sin(5*x);
y  = func1(x);
y2 = func2(x);
% y=ones(1,2500)./5;
sets(2).x_values = x;
sets(1).x_values = x;
sets(2).y_values = y2;
sets(1).y_values = y;

a=0.2;
weight_range    = [-a,a];
struc           = [50,50,17];

net = generate_tanh_feedforward(struc,weight_range,'Bias','active');


% parts = dismantle_signal(net,x,y,'all',2)
ntrainsamples = 15;
% trainsets(1) = generate_train_samples(net,x,y,ntrainsamples);
% trainsets(2) = generate_train_samples(net,x,y2,ntrainsamples);
% tests = generate_test_samples(net,x,y);
trainsets = generate_training_sets(net,sets,ntrainsamples);
tests = generate_test_sets(net,sets);


tic
trainmethod = 'instant Update';
net=multiple_set_train(net, trainsets, 0.001, 0.02, 500, trainmethod);
traintime=toc

% predictionmethod = 'self propagation';
predictionmethod = 'both';


plot_variables = compute_plotvariables_sets(net,x,y,tests,predictionmethod);


figure(2)
subplot(3,2,1)
plot(x(1:trainsets(1).feed_last_Index),y(1:trainsets(1).feed_last_Index))
title(['Eingespeistes Signal 1, ', num2str(ntrainsamples),' Teilstücken, ', trainmethod])
subplot(3,2,2)
plot(x(1:trainsets(2).feed_last_Index),y2(1:trainsets(2).feed_last_Index))
title(['Eingespeistes Signal 2, ', num2str(ntrainsamples),' Teilstücken, ', trainmethod])
subplot(3,2,[3,4])
plot(vertcat(plot_variables.continuous_feed.x_values{:})',vertcat(plot_variables.continuous_feed.y_values{:})',x,y,'-.')
title('continuous feed prediction');
subplot(3,2,[5,6])
plot(vertcat(plot_variables.self_propagation.x_values{:})',vertcat(plot_variables.self_propagation.y_values{:})',x,y,'-.')
title('self propagating prediction');





